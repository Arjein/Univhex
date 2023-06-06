import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hexagon/hexagon.dart';
import 'package:intl/intl.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Pages/Home/post_detail.dart';
import 'package:univhex/Objects/univhex_post.dart';
import 'package:univhex/Pages/Profile/hex_avatar.dart';
import 'package:univhex/Router/app_router.dart';

class UnivhexWidget extends StatefulWidget {
  const UnivhexWidget({
    super.key,
    required this.post,
    required this.order,
  });
  final UnivhexPost post;
  final int order;
  @override
  State<UnivhexWidget> createState() => _UnivhexWidgetState();
}

class _UnivhexWidgetState extends State<UnivhexWidget> {
  Image? _avatarImageProvider;

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
    if (author!.imgUrl == "assets/images/icon.png") {
      _avatarImageProvider = Image.asset(
        "assets/images/icon.png",
        fit: BoxFit.cover,
      );
    } else {
      _avatarImageProvider = Image.network(
        author.imgUrl!,
        fit: BoxFit.cover,
      );
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
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      HexAvatar(
                        isUploading: false,
                        imgUrl: author.imgUrl!,
                        width: CurrentUser.deviceWidth! * 0.14,
                        borderColor: widget.order == -1
                            ? AppColors.myGold
                            : widget.order == 0
                                ? AppColors.mySilver
                                : widget.order == 1
                                    ? AppColors.myBronze
                                    : null,
                      ),
                      CurrentUser.addHorizontalSpace(2),
                      Text(
                        "${author.name} ${author.surname}",
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Expanded(
                        child: Container(
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(widget.post.textContent),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
