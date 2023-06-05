import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Firebase/cloud_storage.dart';
import 'package:univhex/Firebase/firestore.dart';
import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Objects/post_interaction_bar.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Objects/univhex_post_widget.dart';
import 'package:univhex/Router/app_router.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage(name: 'ProfilePageRoute')
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.user});
  final AppUser? user;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isUploading = false;

  Future<void> selectProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    debugPrint(pickedFile.toString());
    if (pickedFile != null) {
      // Use the picked image file for further processing (e.g., upload to Firebase Storage)
      setState(() {
        _isUploading = true;
      });

      final imageFile = File(pickedFile.path);

      // Call the uploadProfilePicture function to upload the selected image to Firebase Storage
      final String imgURL =
          await uploadProfilePicture(widget.user!.id!, imageFile.path);

      setState(() {
        saveProfilePictureUrl(widget.user!.id!, imgURL);
        _isUploading = false;
      });
    } else {
      // Handle when the user cancels the image selection
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
      body: Column(
        children: [
          CurrentUser.addVerticalSpace(3),
          SizedBox(
            height: CurrentUser.deviceHeight! * 0.22,
            width: CurrentUser.deviceWidth,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    selectProfilePicture();
                  },
                  child: HexagonWidget.flat(
                    width: CurrentUser.deviceWidth! * 0.4,
                    color: AppColors.myPurple,
                    child: !_isUploading
                        ? AspectRatio(
                            aspectRatio: HexagonType.FLAT.ratio,
                            child: HexagonWidget.flat(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: AspectRatio(
                                aspectRatio: HexagonType.FLAT.ratio,
                                child: widget.user!.imgUrl ==
                                        'assets/images/icon.png'
                                    ? Image.asset(
                                        'assets/images/icon.png',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        CurrentUser.user!.imgUrl!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          )
                        : CircularProgressIndicator(
                            backgroundColor: AppColors.myPurple,
                            color: AppColors.myBlue),
                  ),
                ),
                CurrentUser.addVerticalSpace(1),
                Text(
                  "${widget.user!.name} ${widget.user!.surname}",
                  style: Theme.of(context).textTheme.headlineSmall,
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
          CurrentUser.addVerticalSpace(1.2),
          ProfileTabBar(userId: widget.user!.id!)
        ],
      ),
    );
  }
}

class ProfileTabBar extends StatefulWidget {
  const ProfileTabBar({super.key, required this.userId});
  final String userId;
  @override
  State<ProfileTabBar> createState() => _ProfileTabBarState();
}

class _ProfileTabBarState extends State<ProfileTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        height: CurrentUser.deviceHeight! * 0.46,
        child: Column(
          children: [
            TabBar(
              indicatorColor: AppColors.myAqua,
              tabs: [
                Tab(icon: Icon(Icons.post_add_outlined)),
                Tab(icon: Icon(Icons.question_mark)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  UserPostList(userId: widget.userId),
                  const UserInformation(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInformation extends StatelessWidget {
  // This is the personal information view which is found in profile's '?'. Edit as you like --> (Cagla Köse)
  const UserInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<int, String> _gradeMap = {1: 'st', 2: 'nd', 3: 'rd', 4: "th"};
    int grade = int.parse(CurrentUser.user!.yearOfStudy!);
    String year = _gradeMap[grade]!;
    String name = CurrentUser.user!.name![0].toUpperCase() +
        CurrentUser.user!.name!.substring(1);
    String surname = CurrentUser.user!.surname![0].toUpperCase() +
        CurrentUser.user!.surname!.substring(1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text(CurrentUser.user!.university!)),
          CurrentUser.addVerticalSpace(2),
          Text("$name $surname"),
          CurrentUser.addVerticalSpace(2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(CurrentUser.user!.fieldOfStudy!),
              Text("${CurrentUser.user!.yearOfStudy!}$year Grade"),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
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
          return const CircularProgressIndicator();
        } else {
          List<UnivhexPost> dataList = snapshot.data ?? [];

          // UnivhexPost currentPost = dataList[index];
          return dataList.isNotEmpty
              ? ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    UnivhexPost currentPost = dataList[index];
                    return Column(
                      children: [
                        UnivhexPostWidget(
                          post: currentPost,
                          height: 0,
                        ),
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
