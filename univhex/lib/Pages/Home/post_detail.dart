import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Objects/app_comment.dart';
import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Objects/post_interaction_bar.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Objects/univhex_post_widget.dart';

import '../../Objects/comment_widget.dart';

@RoutePage(name: "PostDetailRoute")
class PostDetail extends StatefulWidget {
  const PostDetail({super.key, required this.post});
  final UnivhexPost post;

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    debugPrint("This widget was built!");

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Post Flood"),
        ),
        body: Column(
          children: [
            UnivhexPostWidget(
              post: widget.post,
              height: CurrentUser.deviceHeight! * 0.05,
            ),
            const Divider(
              height: 0,
              color: AppColors.obsidianInvert,
              thickness: 0.5,
            ),
            PostInteractionBar(post: widget.post),
            const Divider(
              height: 0,
              color: AppColors.obsidianInvert,
              thickness: 0.5,
            ),

            const Divider(
              height: 0.2,
              color: AppColors.myAqua,
              thickness: 1,
            ),
            CurrentUser.addVerticalSpace(1),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.post.comments.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: widget.post.comments.length,
                            itemBuilder: (context, index) {
                              return CommentWidget(
                                  comment: AppComment.fromJson(
                                      widget.post.comments[index]));
                            },
                          ),
                        )
                      : Container(),
                  TextField(
                    minLines: 1,
                    maxLines: 6,
                    decoration: InputDecoration(
                      prefixIcon: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: SizedBox(
                          width: 22,
                          child: Image.asset(
                            'assets/images/anonymous.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors.myPurple,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(24)),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.myLightBlue, width: 1.0),
                      ),
                      hintText: "Leave a comment!",
                      suffixIcon: TextButton(
                        onPressed: () {
                          // TODO Leave Comment
                          AppComment comment = AppComment(
                            userid: CurrentUser.user!.id!,
                            textContent: _controller.text,
                            dateTime: DateTime.now(),
                          );
                          setState(() {
                            widget.post.addComment(comment);
                          });
                        },
                        child: const Text("Share"),
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    controller: _controller,
                  ),
                ],
              ),
            )
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
  debugPrint("Back pressed: in post?: ${CurrentUser.inPost}");
  // Return true to allow the back button to pop the current screen
  return Future.value(true);
}
