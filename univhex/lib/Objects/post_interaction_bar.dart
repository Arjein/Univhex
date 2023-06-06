import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Objects/univhex_post.dart';

import 'package:univhex/Router/app_router.gr.dart';

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
  int? timePassed;
  String? timeType = "";
  void calcTime() {
    Duration timeDiff = DateTime.now().difference(widget.post.dateTime);

    if (timeDiff.inDays > 0) {
      timePassed = timeDiff.inDays;
      timeType = "d";
    } else {
      if (timeDiff.inHours > 0) {
        timePassed = timeDiff.inHours;
        timeType = "h";
      } else {
        if (timeDiff.inMinutes > 2) {
          timePassed = timeDiff.inMinutes;
          timeType = "m";
        } else {
          if (timeDiff.inMinutes < 2) {
            timePassed = null;
            timeType = "now";
          }
        }
      }
    }
  }

  void onPressedReportButton() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Confirmation'),
        content: const Text('Are you sure you want to report this post?'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              context.router.pop();
            },
            child: const Text('Report'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppColors.myLightBlue),
            onPressed: () => context.router.pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Report submitted successfully'),
          ),
        );
      } catch (e) {
        // Handle network or server errors
        // ignore: use_build_context_synchronously
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
    calcTime();

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

                      if (CurrentUser.inPost == false ||
                          CurrentUser.inPost == null) {
                        CurrentUser.inPost = true;
                        context.router.push(
                          PostDetailRoute(
                              post: widget.post,
                              autoFocus: true,
                              refreshHome: null),
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

              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    timePassed != null
                        ? timePassed.toString() + " " + timeType!
                        : timeType!,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
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
                          decoration: BoxDecoration(color: AppColors.bgColor),
                          height: CurrentUser.deviceHeight! * 0.3,
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.red,
                                    backgroundColor: AppColors.myBlack,
                                  ),
                                  onPressed: onPressedReportButton,
                                  child: const Text('Report'),
                                ),
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
