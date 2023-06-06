import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Router/app_router.gr.dart';

import '../Constants/AppColors.dart';
import 'app_user.dart';

class UnivhexPostWidget extends StatefulWidget {
  const UnivhexPostWidget({
    super.key,
    required this.post,
  });
  final UnivhexPost post;

  @override
  State<UnivhexPostWidget> createState() => _UnivhexPostWidgetState();
}

class _UnivhexPostWidgetState extends State<UnivhexPostWidget> {
  ImageProvider<Object>? _avatarImageProvider;

  late Future<AppUser?> _authorFuture;

  @override
  void initState() {
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
            return const SizedBox();
          } else if (snapshot.hasError) {
            return const Text('Error: Check your Internet Connection');
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

                  context.router.push(
                    PostDetailRoute(
                      post: widget.post,
                      autoFocus: false,
                      refreshHome: null,
                    ),
                  );
                }
              }, //
              child: Container(
                padding: const EdgeInsets.all(16),
                color: AppColors.bgColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (author.id != CurrentUser.user!.id) {
                          context.router.push(ProfilePageRoute(user: author));
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
                                ? "${author.camelAttr(author.name!)} ${author.camelAttr(author.surname!)}"
                                : "Anonymous",
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                DateFormat('HH:mm . d, MMMM')
                                    .format(widget.post.dateTime),
                                style: const TextStyle(
                                    color: AppColors.obsidianInvert),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CurrentUser.addVerticalSpace(2),
                    if (widget.post.media != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          widget.post.media!,
                          fit: BoxFit.cover,
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
