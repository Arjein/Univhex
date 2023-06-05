import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Firebase/firestore.dart';

import 'package:univhex/Objects/post_interaction_bar.dart';
import 'package:univhex/Pages/Home/univhex_add_post_widget.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Objects/univhex_post_widget.dart';

@RoutePage(name: 'HomePageRoute')
class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<UnivhexPost>> _feedFuture;

  Future<void> _refreshFeed() async {
    setState(() {
      debugPrint("Refresh Feed");
      _feedFuture = fetchFeed(CurrentUser.user!.university!);
    });
  }

  @override
  void initState() {
    super.initState();
    _feedFuture = fetchFeed(CurrentUser.user!.university!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
            padding: EdgeInsets.only(left: 13),
            child: Image.asset("assets/images/icon.png")),
        title: Text(CurrentUser.user!.university!.toString()),
      ),
      body: RefreshIndicator(
        color: AppColors.myAqua,
        backgroundColor: AppColors.myPurple,
        displacement: 0,
        onRefresh: _refreshFeed,
        child: FutureBuilder<List<UnivhexPost>>(
          future: _feedFuture,
          builder: (context, snapshot) {
            bool isRefreshing =
                snapshot.connectionState == ConnectionState.waiting;

            if (snapshot.hasError) {
              return Center(child: Text("Error Occurred ${snapshot.error}"));
            } else {
              List<UnivhexPost> dataList = snapshot.data ?? [];
              return CustomScrollView(
                slivers: [
                  isRefreshing
                      ? SliverToBoxAdapter(
                          child: CurrentUser.addVerticalSpace(5),
                        )
                      : SliverToBoxAdapter(child: Container()),
                  SliverToBoxAdapter(
                    child: AddPostWidget(callback: _refreshFeed),
                  ),
                  // Show the posts if there are any, or an empty widget

                  if (dataList.isNotEmpty)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        addRepaintBoundaries: false,
                        (context, index) {
                          UnivhexPost currentPost = dataList[index];

                          return Column(
                            children: [
                              GestureDetector(
                                onDoubleTap: () {
                                  setState(() {
                                    if (!currentPost.hexedBy
                                        .contains(CurrentUser.user!.email)) {
                                      currentPost.addLike();
                                    }
                                  });
                                },
                                child: UnivhexPostWidget(
                                  post: currentPost,
                                  height: 0,
                                ),
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
                        childCount: dataList.length,
                      ),
                    ),
                  // Show the circular progress indicator only during refresh

                  // Show the AddPostWidget regardless of refresh state
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
