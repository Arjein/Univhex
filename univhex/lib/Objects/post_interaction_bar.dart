import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Firebase/cloud_storage.dart';
import 'package:univhex/Objects/post_detail.dart';
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
  @override
  Widget build(BuildContext context) {
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
                    icon:
                        !widget.post.hexedBy.contains(CurrentUser.user!.email!)
                            ? const Icon(Icons.hexagon_outlined)
                            : Image.asset("assets/images/icon.png"),
                    onPressed: () async {
                      // UnivhexPost? retrievedPost = await readPostfromDB(widget.post);
                      debugPrint("POST ID: ${widget.post.id}");
                      final postsCollection =
                          FirebaseFirestore.instance.collection('Posts');
                      final postRef = postsCollection.doc(widget.post.id);
                      debugPrint(postRef.toString());

                      setState(() {
                        // Like alınca veritabanına kaydedebiliriz.
                        if (widget.post.hexedBy
                            .contains(CurrentUser.user!.email!)) {
                          widget.post.hexedBy.remove(CurrentUser.user!.email);
                        } else {
                          widget.post.hexedBy.add(CurrentUser.user!.email!);
                        }
                      });
                      postRef.update({'HexedBy': widget.post.hexedBy});
                    },
                  ),
                  Column(
                    children: [
                      CurrentUser.addVerticalSpace(1.8),
                      Text(
                        widget.post.hexedBy.length.toString(),
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
                        context.router.push(PostDetailRoute(post: widget.post));
                      }
                      
                    },
                  ),
                  Text(
                    widget.post.commentBy.length.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              IconButton(
                alignment: Alignment.centerRight,
                icon:
                    const Icon(Icons.flag_outlined, color: AppColors.myPurple),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
