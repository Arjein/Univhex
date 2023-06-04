import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Firebase/cloud_storage.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Router/app_router.dart';
import '../../Objects/app_user.dart';

class AddPostWidget extends StatefulWidget {
  const AddPostWidget({super.key, required this.callback});
  final Future<void> Function() callback;
  @override
  State<AddPostWidget> createState() => _AddPostWidgetState();
}

class _AddPostWidgetState extends State<AddPostWidget> {
  final TextEditingController controller = TextEditingController();
  bool isAnonymous = false; // Set this flag to true for anonymous posts
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CurrentUser.deviceHeight! * 0.2,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Divider(
              height: 0.2,
              color: AppColors.obsidianInvert,
              thickness: 0.5,
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            'assets/images/anonymous.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Switch(
                      // This bool value toggles the switch.
                      value: isAnonymous,
                      activeColor: AppColors.myBlue,
                      inactiveThumbColor: AppColors.myPurple,
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          isAnonymous = value;
                        });
                      },
                    ),
                  ],
                ),
                PostTextArea(
                  controller: controller,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: PostButton(
                    callbackFunction: widget.callback,
                    controller: controller,
                    isAnonymous: isAnonymous,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.myPink,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}

class PostButton extends StatefulWidget {
  PostButton({
    super.key,
    required this.callbackFunction,
    required this.controller,
    required this.isAnonymous,
  });
  final Future<void> Function() callbackFunction;
  final TextEditingController controller;
  final bool isAnonymous;
  // Needed for univhex Post

  @override
  State<PostButton> createState() => _PostButtonState();
}

class _PostButtonState extends State<PostButton> {
  bool isPosting = false;

  @override
  void handlePostButtonPressed() {
    if (widget.controller.text == null || widget.controller.text == '') {
      return;
    }
    setState(() {
      isPosting = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      _performPostOperation(widget.isAnonymous).then((_) {
        setState(() {
          isPosting = false;
        });
        widget.callbackFunction();
        widget.controller.clear();
      });
    });
  }

  Widget build(BuildContext context) {
    return !isPosting
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    widget.isAnonymous ? AppColors.myBlue : AppColors.myPurple,
                disabledBackgroundColor: AppColors.myAqua.withAlpha(1)),
            onPressed: isPosting ? null : handlePostButtonPressed,
            child: const Text('Post'),
          )
        : const Padding(
            padding: EdgeInsets.only(right: 20.0, bottom: 12),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              ),
            ),
          ); // Show the progress indicator when isPosting is true
  }

  _performPostOperation(bool isAnonymous) async {
    DateTime dateTime = DateTime.now();

    UnivhexPost newPost = UnivhexPost(
      id: "",
      postedBy: CurrentUser.user,
      university: CurrentUser.user!.university!,
      textContent: widget.controller.text,
      isAnonymous: isAnonymous,
      dateTime: dateTime,
      hexedBy: [],
      comments: [],
    );

    if (await addNewPostDB(newPost)) {
      debugPrint("Post successfully added to Database!");
    }
  }
}

class PostTextArea extends StatefulWidget {
  const PostTextArea({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;
  @override
  State<PostTextArea> createState() => _PostTextAreaState();
}

class _PostTextAreaState extends State<PostTextArea> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GestureDetector(
          onTap: () {
            debugPrint("statement");
          },
          child: TextField(
            minLines: 6,
            maxLines: null,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: "What is happening?!"),
            keyboardType: TextInputType.multiline,
            controller: widget.controller,
            onChanged: (text) {
              debugPrint(widget.controller.text);
            },
          ),
        ),
      ),
    );
  }
}
