import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/Constants.dart';

import 'package:univhex/Objects/post_interaction_bar.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Objects/univhex_post_widget.dart';

@RoutePage(name: 'HomePageRoute')
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: ListView.builder(
        itemCount: Constants.UnivhexPosts.length,
        itemBuilder: (context, index) {
          UnivhexPost currentPost = Constants.UnivhexPosts[index];
          return Column(
            children: [
              UnivhexPostWidget(post: currentPost, height: 0),
              PostInteractionBar(
                post: currentPost,
              ),
              const Divider(
                height: 0,
                // indent: 10,
                color: AppColors.obsidianInvert,
                thickness: 0.5,
              )
            ],
          );
        },
      ),
    );
  }
}
