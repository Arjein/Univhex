import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Objects/univhex_post.dart';

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
            return const SizedBox();
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
                      Stack(alignment: Alignment.center, children: [
                        SizedBox(
                          width: CurrentUser.deviceWidth! * 0.18,
                          child: Transform.rotate(
                            angle: pi /
                                2, // Rotate 90 degrees. Dart uses radians, not degrees, hence we use pi/2.
                            child: Lottie.network(
                                'https://assets9.lottiefiles.com/packages/lf20_d6619szt.json'),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.myAqua,
                              width: 1.5,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: _avatarImageProvider!.image,
                          ),
                        ),
                      ]),
                      CurrentUser.addHorizontalSpace(2),
                      Text(
                        "${author.camelAttr(author.name!)} ${author.camelAttr(author.surname!)}",
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
                      child: Row(
                        children: [
                          Expanded(child: Text(widget.post.textContent)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                width: 40,
                                child: Image.asset("assets/images/icon.png"),
                              ),
                              CurrentUser.addHorizontalSpace(2),
                              Text(
                                widget.post.hexCount.toString(),
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
