import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Objects/post_detail.dart';
import 'package:univhex/Objects/univhex_post.dart';

import '../Constants/AppColors.dart';
import '../Router/app_router.dart';

class UnivhexPostWidget extends StatefulWidget {
  const UnivhexPostWidget({
    super.key,
    required this.post,
    required this.height,
  });
  final UnivhexPost post;
  final double height;

  @override
  State<UnivhexPostWidget> createState() => _UnivhexPostWidgetState();
}

class _UnivhexPostWidgetState extends State<UnivhexPostWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (CurrentUser.inPost == null || CurrentUser.inPost == false) {
          CurrentUser.inPost = true;
          debugPrint("User Inpost?: ${CurrentUser.inPost}");
          context.router.push(PostDetailRoute(post: widget.post));
        }
      },
      onDoubleTap: () {
        setState(() {
          !widget.post.hexedBy.contains(CurrentUser.user)
              ? widget.post.hexedBy.add(CurrentUser.user)
              : null;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        color: AppColors.bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // height: CurrentUser.deviceHeight! * 0.05,
              // height: height,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.obsidianInvert,
                    child: Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text("Img"),
                    ),
                  ),
                  CurrentUser.addHorizontalSpace(5),
                  Text(
                    !widget.post.isAnonymous
                        ? "${widget.post.postedBy!.name} ${widget.post.postedBy!.surname}"
                        : "Anonymous",
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(widget.post.textContent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
