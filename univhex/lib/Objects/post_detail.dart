import 'package:flutter/material.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Objects/post_interaction_bar.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Objects/univhex_post_widget.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({super.key, required this.post});
  final UnivhexPost post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post Flood")),
      body: Column(
        children: [
          UnivhexPostWidget(
              post: post, height: CurrentUser.deviceHeight! * 0.05),
          PostInteractionBar(post: post),
        ],
      ),
    );
  }
}
