import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Firebase/firestore.dart';
import 'package:univhex/Pages/Home/post_detail.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Router/app_router.dart';

class PostInteractionBar extends StatefulWidget {
  const PostInteractionBar({
    Key? key,
    required this.post,
  }) : super(key: key);
  final UnivhexPost post;
  @override
  State<PostInteractionBar> createState() => _PostInteractionBarState();
}

class _PostInteractionBarState extends State<PostInteractionBar> {
  void showReportBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onPressedReportButton,
                child: const Text('Report'),
              ),
            ],
          ),
        );
      },
    );
  }

  void onPressedReportButton() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Confirmation'),
        content: const Text('Are you sure you want to report this post?'),
        actions: [
          TextButton(
            onPressed: () {
              context.router.pop();
            },
            child: const Text('Report'),
          ),
          TextButton(
            onPressed: () => context.router.pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // 3. Gather additional information (optional)

      // ...

      // 4. Send the report
      try {
        // Check response status and provide appropriate feedback to the user

        // 5. Provide feedback to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Report submitted successfully'),
          ),
        );
      } catch (e) {
        // Handle network or server errors
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Failed to submit the report. Please check your internet connection and try again.'),
            actions: [
              TextButton(
                onPressed: () => context.router.pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.post.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColors.bgColor,
          height: CurrentUser.deviceHeight! * 0.055,
          width: CurrentUser.deviceWidth!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: !widget.post.hexedBy.contains(CurrentUser.user!.id)
                        ? const Icon(Icons.hexagon_outlined)
                        : Image.asset("assets/images/icon.png"),
                    onPressed: () async {
                      setState(() {
                        widget.post.addLike();
                      });
                    },
                  ),
                  Column(
                    children: [
                      CurrentUser.addVerticalSpace(1.8),
                      Text(
                        widget.post.hexCount.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  CurrentUser.addHorizontalSpace(
                      5), // Space between Hex and Comment
                  IconButton(
                    icon: const Icon(Icons.add_comment_outlined,
                        color: AppColors.myAqua),
                    onPressed: () {
                      // Navigate to post content page. A new page will be constructed for this.

                      debugPrint("inPost: ${CurrentUser.inPost}");
                      if (CurrentUser.inPost == false ||
                          CurrentUser.inPost == null) {
                        CurrentUser.inPost = true;
                        context.router.push(
                          PostDetailRoute(post: widget.post, autoFocus: true),
                        );
                      }
                    },
                  ),
                  Text(
                    widget.post.comments.length.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              // Report Button
              IconButton(
                alignment: Alignment.centerRight,
                icon: const Icon(Icons.more_horiz,
                    color: AppColors.obsidianInvert),
                onPressed: () {
                  //TODO Implement Report logic

                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: onPressedReportButton,
                                child: const Text('Report'),
                              ),
                            ],
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
