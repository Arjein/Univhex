import 'package:flutter/material.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Objects/post_interaction_bar.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Objects/univhex_post_widget.dart';
import 'package:univhex/Widgets/appBottomNavBar.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({super.key, required this.post});
  final UnivhexPost post;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Post Flood"),
        ),
        body: Column(
          children: [
            UnivhexPostWidget(
                post: post, height: CurrentUser.deviceHeight! * 0.05),
            //PostInteractionBar(post: post),

            // Comment Field
          ],
        ),
      ),
    );
  }
}

Future<bool> _onBackPressed() {
  // Set your variable to false here
  CurrentUser.inPost = false;

  // Return true to allow the back button to pop the current screen
  return Future.value(true);
}
