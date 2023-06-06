import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Objects/app_comment.dart';
import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Router/app_router.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({Key? key, required this.comment}) : super(key: key);
  final AppComment comment;

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  Future<AppUser?>? _authorFuture;

  @override
  void initState() {
    super.initState();
    _authorFuture = widget.comment.retrieveAuthor();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppUser?>(
      future: _authorFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final author = snapshot.data;

          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  child: CircleAvatar(
                    child: GestureDetector(
                      child: Image.asset(
                        'assets/images/icon.png',
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        CurrentUser.inPost = false;
                        if (author!.email != CurrentUser.user!.email) {
                          context.router.push(ProfilePageRoute(user: author));
                        } else {
                          debugPrint("Same Person");
                        }
                      },
                    ),
                  ),
                ),
                CurrentUser.addHorizontalSpace(1),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${author!.name} ${author.surname}",
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      Text(widget.comment.textContent),
                      Divider(
                        height: 0.5,
                        thickness: 0.5,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
