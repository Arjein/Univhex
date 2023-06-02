import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Objects/post_interaction_bar.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Objects/univhex_post_widget.dart';

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
            CurrentUser.addVerticalSpace(2),
            // Comment Field
            TextField(
              minLines: 1,
              maxLines: 6,
              decoration: InputDecoration(
                  icon: SizedBox(
                    width: 30,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SizedBox(
                        width: 22,
                        child: Image.asset(
                          'assets/images/anonymous.png',
                          fit: BoxFit.fitWidth,
                        ),
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
                    borderSide:
                        BorderSide(color: AppColors.myLightBlue, width: 1.0),
                  ),
                  hintText: "Leave a comment!",
                  suffix: TextButton(
                      onPressed: () {
                        // TODO Leave Comment
                      },
                      child: Text("Share"))),
              keyboardType: TextInputType.multiline,
              controller: _controller,
            ),
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
