import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Objects/app_user.dart';

class AppComment {
  final String userid;
  final String textContent;
  final DateTime dateTime;

  AppComment({
    required this.userid,
    required this.textContent,
    required this.dateTime,
  });
  Map<String, dynamic> toFirestore() {
    return {
      "UserId": userid,
      "TextContent": textContent,
      "Datetime": dateTime,
    };
  }

  factory AppComment.fromJson(Map<String, dynamic> jsonData) {
    return AppComment(
      userid: jsonData["UserId"],
      textContent: jsonData["TextContent"],
      dateTime: jsonData["Datetime"]is DateTime ?  jsonData['Datetime']:jsonData["Datetime"].toDate() ,
    );
  }

  factory AppComment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final jsonData = snapshot.data();
    return AppComment(
      userid: jsonData!["UserId"],
      textContent: jsonData["TextContent"],
      dateTime: jsonData["Datetime"].toDate(),
    );
  }

  Future<AppUser?> retrieveAuthor() async {
    try {
      final ref = FirebaseFirestore.instance
          .collection("Users")
          .doc(userid)
          .withConverter(
            fromFirestore: AppUser.fromFirestore,
            toFirestore: (AppUser user, _) => user.toFirestore(),
          );
      debugPrint("USER_id:" + userid);
      final docSnap = await ref.get();

      final AppUser user = docSnap.data()!;
      debugPrint("RETRIEVED USER:" + user.toString());
      return user;
    } catch (e) {
      return null;
    }
  }
}
