import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/Constants.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Firebase/cloud_storage.dart';

import 'package:univhex/Objects/post_interaction_bar.dart';
import 'package:univhex/Objects/univhex_add_post_widget.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Objects/univhex_post_widget.dart';

@RoutePage(name: 'HomePageRoute')
class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Stream<List<UnivhexPost>> _feedStream;

  @override
  void initState() {
    super.initState();
    _feedStream = fetchFeedStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CurrentUser.user!.university!.toString()),
      ),
      body: StreamBuilder<List<UnivhexPost>>(
        stream: _feedStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error Occurred ${snapshot.error}"));
          } else {
            List<UnivhexPost> dataList = snapshot.data ?? [];
            debugPrint(dataList.length.toString());
            return dataList.length != 0
                ? CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: AddPostWidget(),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
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
                          childCount: dataList.length,
                        ),
                      ),
                    ],
                  )
                : AddPostWidget();
          }
        },
      ),
    );
  }
}
