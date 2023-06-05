import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Pages/Home/post_detail.dart';
import 'package:univhex/Objects/univhex_post.dart';

import '../Constants/AppColors.dart';
import '../Router/app_router.dart';
import 'app_user.dart';

class UnivhexPostWidget extends StatefulWidget {
  const UnivhexPostWidget({
    Key? key,
    required this.post,
    required this.height,
  });
  final UnivhexPost post;
  final double height;
  @override
  State<UnivhexPostWidget> createState() => _UnivhexPostWidgetState();
}

class _UnivhexPostWidgetState extends State<UnivhexPostWidget> {
  ImageProvider<Object>? _avatarImageProvider;

  late Future<AppUser?> _authorFuture;

  @override
  void initState() {
    // TODO: implement initState
    _authorFuture = retrieveAuthor();
    super.initState();
  }

  Future<AppUser?> retrieveAuthor() async {
    final author = await widget.post.retrieveAuthor();
    _loadAvatarImage(author);
    return author;
  }

  void _loadAvatarImage(AppUser? author) {
    if (widget.post.isAnonymous) {
      _avatarImageProvider =
          const AssetImage('assets/images/launcher_icon.png');
    } else {
      if (author!.imgUrl == "assets/images/icon.png") {
        _avatarImageProvider = const AssetImage("assets/images/icon.png");
      } else {
        _avatarImageProvider = NetworkImage(author.imgUrl!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppUser?>(
        future: _authorFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Error loading author');
          } else {
            final author = snapshot.data;
            if (author == null) {
              return const Text('Author not found');
            }
            _loadAvatarImage(author);
            return GestureDetector(
              onTap: () {
                if (CurrentUser.inPost == null || CurrentUser.inPost == false) {
                  CurrentUser.inPost = true;
                  debugPrint("User Inpost?: ${CurrentUser.inPost}");
                  context.router.push(
                    PostDetailRoute(
                      post: widget.post,
                      autoFocus: false,
                    ),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                color: AppColors.bgColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (author.email != CurrentUser.user!.email) {
                          context.router.push(ProfilePageRoute(user: author));
                        } else {
                          debugPrint("Same Person");
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.myLightBlue,
                                width: 1.5,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: _avatarImageProvider,
                            ),
                          ),
                          CurrentUser.addHorizontalSpace(2),
                          Text(
                            !widget.post.isAnonymous
                                ? "${author.name} ${author.surname}"
                                : "Anonymous",
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                DateFormat('HH:mm . d, MMMM')
                                    .format(widget.post.dateTime),
                                style:
                                    TextStyle(color: AppColors.obsidianInvert),
                              ),
                            ),
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
        });
  }
}
