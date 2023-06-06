import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Firebase/cloud_storage.dart';
import 'package:univhex/Firebase/firestore.dart';
import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Objects/post_interaction_bar.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Objects/univhex_post_widget.dart';
import 'package:univhex/Pages/Profile/hex_avatar.dart';

import 'package:univhex/Router/app_router.gr.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage(name: 'ProfilePageRoute')
class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, required this.user});
  AppUser? user;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isUploading = false;

  Future<void> _reloadProfile() async {
    widget.user = await readUserfromDB(widget.user!.id!);
    setState(() {});
  }

  Future<void> selectProfilePicture(bool delete) async {
    late String imgURL;
    XFile? pickedFile;
    if (delete) {
      imgURL = "assets/images/icon.png";
    }

    if (!delete) {
      final picker = ImagePicker();
      pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _isUploading = true;
        });

        final imageFile = File(pickedFile.path);
        imgURL = await uploadProfilePicture(widget.user!.id!, imageFile.path);
      }
    }
    if (pickedFile != null) {
      setState(() {
        saveProfilePictureUrl(widget.user!.id!, imgURL);
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text(
          widget.user!.email!,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(const SettingsRoute());
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.myLightBlue,
        backgroundColor: AppColors.bgColor,
        onRefresh: () {
          return _reloadProfile();
        },
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CurrentUser.addVerticalSpace(3),
                    SizedBox(
                      height: CurrentUser.deviceHeight! * 0.22,
                      width: CurrentUser.deviceWidth,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: CurrentUser.user!.id! == widget.user!.id!
                                ? () {
                                    showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            decoration: const BoxDecoration(
                                                color: AppColors.bgColor),
                                            height:
                                                CurrentUser.deviceHeight! * 0.3,
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              AppColors
                                                                  .obsidianInvert,
                                                          backgroundColor:
                                                              AppColors.myBlack,
                                                        ),
                                                        onPressed: () {
                                                          selectProfilePicture(
                                                              false);
                                                        },
                                                        child: const Text(
                                                            'Choose a Picture'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              Colors.red,
                                                          backgroundColor:
                                                              AppColors.myBlack,
                                                        ),
                                                        onPressed: () {
                                                          selectProfilePicture(
                                                              true);
                                                        },
                                                        child: const Text(
                                                            'Delete Profile Picture'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  }
                                : () {},
                            child: HexAvatar(
                              isUploading: _isUploading,
                              imgUrl: widget.user!.imgUrl!,
                              width: CurrentUser.deviceWidth! * 0.4,
                            ),
                          ),
                          CurrentUser.addVerticalSpace(1),
                          Text(
                            "${widget.user!.camelAttr(widget.user!.name!)} ${widget.user!.camelAttr(widget.user!.surname!)}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: AppColors.obsidianInvert),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.user!.hexPoints.toString(),
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        CurrentUser.addHorizontalSpace(2),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.13,
                          child: Image.asset("assets/images/icon.png"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(child: CurrentUser.addVerticalSpace(1.2)),
            ];
          },
          body: ProfileTabBar(
            user: widget.user!,
          ),
        ),
      ),
    );
  }
}

class ProfileTabBar extends StatefulWidget {
  const ProfileTabBar({
    super.key,
    required this.user,
  });
  final AppUser user;
  @override
  State<ProfileTabBar> createState() => _ProfileTabBarState();
}

class _ProfileTabBarState extends State<ProfileTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            indicatorColor: AppColors.myAqua,
            tabs: [
              Tab(icon: Icon(Icons.post_add_outlined)),
              Tab(icon: Icon(Icons.question_mark)),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                UserPostList(userId: widget.user.id!),
                UserInformation(user: widget.user),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserInformation extends StatelessWidget {
  // This is the personal information view which is found in profile's '?'. Edit as you like --> (Cagla Köse)
  const UserInformation({
    Key? key,
    required this.user,
  }) : super(key: key);
  final AppUser user;
  @override
  Widget build(BuildContext context) {
    Map<int, String> gradeMap = {1: 'st', 2: 'nd', 3: 'rd', 4: "th"};
    int grade = int.parse(user.yearOfStudy!);
    String year = gradeMap[grade]!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CurrentUser.addVerticalSpace(2),
          Center(
              child: Text(
            user.university!.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: AppColors.obsidianInvert),
          )),
          CurrentUser.addVerticalSpace(4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user.camelAttr(user.fieldOfStudy!),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.obsidianInvert),
              ),
              Text(
                "${user.yearOfStudy!}$year Grade",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.obsidianInvert,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserPostList extends StatefulWidget {
  const UserPostList({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;

  @override
  State<UserPostList> createState() => _UserPostListState();
}

class _UserPostListState extends State<UserPostList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchUserPosts(widget.userId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error Occurred ${snapshot.error}"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else {
          List<UnivhexPost> dataList = snapshot.data ?? [];
          return dataList.isNotEmpty
              ? ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    UnivhexPost currentPost = dataList[index];
                    return Column(
                      children: [
                        UnivhexPostWidget(
                            post: currentPost, userid: widget.userId),
                        PostInteractionBar(post: currentPost),
                        const Divider(
                          height: 0,
                          color: AppColors.obsidianInvert,
                          thickness: 0.5,
                        ),
                      ],
                    );
                  },
                )
              : Container();
        }
      },
    );
  }
}
