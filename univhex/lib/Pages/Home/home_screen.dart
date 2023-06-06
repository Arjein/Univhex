import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Firebase/firestore.dart';

import 'package:univhex/Objects/post_interaction_bar.dart';
import 'package:univhex/Pages/Home/univhex_add_post_widget.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Objects/univhex_post_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:univhex/Widgets/univhex_progress_indicator.dart';

@RoutePage(name: 'HomePageRoute')
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<UnivhexPost>> _feedFuture;
  final FocusNode _focusNode = FocusNode();

  Future<void> _refreshFeed() async {
    _feedFuture = fetchFeed(CurrentUser.user!.university!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _feedFuture = fetchFeed(CurrentUser.user!.university!);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.only(left: 13),
          child: Image.asset("assets/images/icon.png"),
        ),
        title: Text(CurrentUser.user!.university!.toUpperCase()),
      ),
      body: RefreshIndicator(
        color: AppColors.myLightBlue,
        backgroundColor: AppColors.bgColor,
        displacement: 0,
        onRefresh: _refreshFeed,
        child: FutureBuilder<List<UnivhexPost>>(
          future: _feedFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Error Occurred ${snapshot.error}"));
            } else {
              List<UnivhexPost> dataList = snapshot.data ?? [];
              return GestureDetector(
                onTap: () {
                  if (_focusNode.hasFocus) {
                    _focusNode.unfocus();
                  }
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: UnivhexAddPostWidget(
                        onPressed: _refreshFeed,
                        focusNode: _focusNode,
                      ),
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
                                  onTap: () {
                                    if (_focusNode.hasFocus) {
                                      _focusNode.unfocus();
                                    }
                                  },
                                  onDoubleTap: () {
                                    setState(() {
                                      if (!currentPost.hexedBy
                                          .contains(CurrentUser.user!.id)) {
                                        currentPost.addLike();
                                      }
                                    });
                                  },
                                  child: UnivhexPostWidget(
                                    post: currentPost,
                                    userid: CurrentUser.user!.id!,
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
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
