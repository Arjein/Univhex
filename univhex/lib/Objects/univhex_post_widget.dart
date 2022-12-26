import 'package:flutter/material.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Objects/univhex_post.dart';

import '../Constants/AppColors.dart';

class UnivhexPostWidget extends StatelessWidget {
  const UnivhexPostWidget({
    super.key,
    required this.post,
  });
  final UnivhexPost post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: CurrentUser.deviceHeight! * 0.5,
      color: AppColors.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: AppColors.myBlue,
            height: CurrentUser.deviceHeight! * 0.05,
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text("Img"),
                  ),
                ),
                CurrentUser.addHorizontalSpace(5),
                Text(!post.isAnonymous
                    ? "${post.postedBy!.name} ${post.postedBy!.surname}"
                    : "Anonymous"),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(post.textContent),
          ),
          PostInteractionBar()
        ],
      ),
    );
  }
}

class PostInteractionBar extends StatefulWidget {
  const PostInteractionBar({
    Key? key,
  }) : super(key: key);

  @override
  State<PostInteractionBar> createState() => _PostInteractionBarState();
}

class _PostInteractionBarState extends State<PostInteractionBar> {
  bool isHexed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.myBlack,
      height: CurrentUser.deviceHeight! * 0.055,
      width: CurrentUser.deviceWidth!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                child: IconButton(
                  icon: !isHexed
                      ? const Icon(Icons.hexagon_outlined)
                      // : const Icon(Icons.hexagon),
                      : Image.asset("assets/images/icon.png"),
                  onPressed: () {
                    setState(() {
                      isHexed = !isHexed;
                    });
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_comment_outlined),
                onPressed: () {},
              ),
            ],
          ),
          IconButton(
            alignment: Alignment.centerRight,
            icon: const Icon(Icons.flag_outlined, color: AppColors.myPurple),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
