import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Firebase/cloud_storage.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Router/app_router.dart';

import 'app_user.dart';

class AddPostWidget extends StatefulWidget {
  const AddPostWidget({super.key});

  @override
  State<AddPostWidget> createState() => _AddPostWidgetState();
}

class _AddPostWidgetState extends State<AddPostWidget> {
  String? postText;

  void handlePost(String text) {
    // Process the text, e.g., make the post or update a state variable
    print('Received text: $text');
    setState(() {
      postText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isPosting = false;
    bool isAnonymous = false; // Set this flag to true for anonymous posts

    return SizedBox(
      height: CurrentUser.deviceHeight! * 0.2,
      child: Column(
        children: [
          const Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: const Divider(
              height: 0.2,
              color: AppColors.obsidianInvert,
              thickness: 0.5,
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                PostTextArea(
                  onTextChanged: handlePost,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: PostButton(
                    textcontent: postText,
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
  const PostButton({
    super.key,
    required this.textcontent,
  });

  // Needed for univhex Post
  final String? textcontent;

  @override
  State<PostButton> createState() => _PostButtonState();
}

bool isPosting = false;

class _PostButtonState extends State<PostButton> {
  @override
  void handlePostButtonPressed() {
    if (widget.textcontent == null || widget.textcontent == '') {
      return;
    }
    setState(() {
      isPosting = true;
    });

    bool isAnonymous = false;
    Future.delayed(const Duration(seconds: 1), () {
      _performPostOperation(isAnonymous).then((_) {
        setState(() {
          isPosting = false;
        });
      });
    });
  }

  Widget build(BuildContext context) {
    return !isPosting
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
                disabledBackgroundColor:
                    AppColors.myPurpleMaterial.withAlpha(1)),
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
      textContent: widget.textcontent!,
      isAnonymous: isAnonymous,
      dateTime: dateTime,
      hexedBy: [],
      commentBy: {},
    );
    debugPrint(newPost.textContent);
    debugPrint(newPost.dateTime.toString());
    if (await addNewPostDB(newPost)) {
      debugPrint("Post successfully added to Database!");
    }
  }
}

class PostTextArea extends StatefulWidget {
  const PostTextArea({
    super.key,
    required this.onTextChanged,
  });
  final Function(String) onTextChanged;

  @override
  State<PostTextArea> createState() => _PostTextAreaState();
}

class _PostTextAreaState extends State<PostTextArea> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: TextField(
            minLines: 6,
            maxLines: null,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: "What is happening?!"),
            keyboardType: TextInputType.multiline,
            controller: _controller,
            onChanged: (text) {
              widget.onTextChanged(text);
            },
          ),
        ),
      ),
    );
  }
}
