import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Firebase/firestore.dart';
import 'package:univhex/Objects/app_comment.dart';
import 'package:univhex/Objects/app_user.dart';

class UnivhexPost {
  final String id;
  final String? authorId;
  final String textContent;
  final bool isAnonymous;
  final DateTime dateTime;
  final List<dynamic> hexedBy;
  final List<dynamic> comments;
  final String university;

  UnivhexPost({
    required this.id,
    required this.authorId,
    required this.textContent,
    required this.isAnonymous,
    required this.dateTime,
    required this.hexedBy,
    required this.comments,
    required this.university,
  });

  Future<AppUser> retrieveAuthor() async {
    AppUser? retrievedUser = await readUserfromDB(authorId!);
    return retrievedUser!;
  }

  factory UnivhexPost.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    debugPrint("FROMFIRESTORE (POST)");
    final jsonData = snapshot.data();
    UnivhexPost fetchedPost = UnivhexPost(
      id: snapshot.id,
      authorId: jsonData!["AuthorId"],
      university: jsonData["University"],
      textContent: jsonData["TextContent"],
      isAnonymous: jsonData["isAnonymous"],
      dateTime: jsonData["Datetime"].toDate(),
      hexedBy: jsonData["HexedBy"],
      comments: jsonData["Comments"],
      /*
      comments: (jsonData["CommentBy"] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
            AppUser.fromJson(key as Map<String, dynamic>), value.toString()),
      ),
      */
    );

    return fetchedPost;
  }

// Add like to post
  void addLike() {
    final postsCollection = FirebaseFirestore.instance.collection('Posts');
    final postRef = postsCollection.doc(id);

    // Like alınca veritabanına kaydedebiliriz.
    if (hexedBy.contains(CurrentUser.user!.id)) {
      hexedBy.remove(CurrentUser.user!.id);
    } else {
      hexedBy.add(CurrentUser.user!.id);
    }

    postRef.update({'HexedBy': hexedBy});
  }

// ADDs comment to a post
  void addComment(AppComment comment) {
    final postsCollection = FirebaseFirestore.instance.collection('Posts');
    final postRef = postsCollection.doc(id);

    comments.add(comment.toFirestore());
    postRef.update({'Comments': comments});
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "AuthorId": authorId,
      "University": university,
      "TextContent": textContent,
      "isAnonymous": isAnonymous,
      "Datetime": dateTime,
      "HexedBy": hexedBy,
      "Comments": comments,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Posted By: ${authorId.toString()}, at ${dateTime.toString()}";
  }
}
