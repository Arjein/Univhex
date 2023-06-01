import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Objects/app_user.dart';

class UnivhexPost {
  final String id;
  final AppUser? postedBy;
  final String textContent;
  final bool isAnonymous;
  final DateTime dateTime;
  final List<dynamic> hexedBy;
  final Map<AppUser, String> commentBy;

  UnivhexPost({
    required this.id,
    required this.postedBy,
    required this.textContent,
    required this.isAnonymous,
    required this.dateTime,
    required this.hexedBy,
    required this.commentBy,
  });

  factory UnivhexPost.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final jsonData = snapshot.data();

    UnivhexPost fetchedPost = UnivhexPost(
      id: snapshot.id,
      postedBy: AppUser.fromJson(jsonData!["User"]),
      textContent: jsonData["TextContent"],
      isAnonymous: jsonData["isAnonymous"],
      dateTime: jsonData["Datetime"].toDate(),
      hexedBy: jsonData["HexedBy"],
      commentBy: (jsonData["CommentBy"] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
            AppUser.fromJson(key as Map<String, dynamic>), value.toString()),
      ),
    );

    return fetchedPost;
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "User": postedBy!.toFirestore(),
      "TextContent": textContent,
      "isAnonymous": isAnonymous,
      "Datetime": dateTime,
      "HexedBy": hexedBy,
      "CommentBy": commentBy,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Posted By: ${postedBy.toString()}, at ${dateTime.toString()}";
  }
}
