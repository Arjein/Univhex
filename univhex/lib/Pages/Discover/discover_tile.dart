import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/AppColors.dart';
import 'package:univhex/Objects/app_user.dart';

import 'package:univhex/Router/app_router.gr.dart';

class DiscoverTile extends StatelessWidget {
  const DiscoverTile({super.key, required this.user, required this.image});
  final AppUser user;
  final ImageProvider image;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.myLightBlue,
            width: 1.5,
          ),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: image,
        ),
      ),
      title: Text("${user.name!} ${user.surname}"),
      subtitle: Text(user.email!),
      onTap: () {
        // TODO navigate to user profile
        context.router.push(ProfilePageRoute(user: user));
      },
    );
  }
}
