import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Objects/univhex_post.dart';

Duration delayTime = const Duration(milliseconds: 1600);

Future<bool> registerAppUserDB(AppUser user, User firebaseUser) async {
  try {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseUser.uid)
        .withConverter(
          fromFirestore: AppUser.fromFirestore,
          toFirestore: (AppUser user, options) => user.toFirestore(),
        )
        .set(user);
    return true;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}

Future<bool> addNewPostDB(UnivhexPost newPost) async {
  try {
    final postsCollection = FirebaseFirestore.instance.collection('Posts');
    final newPostRef = postsCollection.doc(); // Create a new document reference
    final newPostId = newPostRef.id; // Get the generated ID

    final updatedPost = UnivhexPost(
      id: newPostId, // Assign the generated ID to the post
      authorId: newPost.authorId,
      university: newPost.university,
      textContent: newPost.textContent,
      isAnonymous: newPost.isAnonymous,
      dateTime: newPost.dateTime,
      hexedBy: newPost.hexedBy,
      hexCount: newPost.hexCount,
      comments: newPost.comments,
      media: newPost.media,
    );

    await newPostRef.set(updatedPost.toFirestore());

    return true;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}
// Kullanıcı postlarını fetchle

Future<List<UnivhexPost>> fetchUserPosts(String userId) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('Posts')
        .where(
          'AuthorId',
          isEqualTo: userId,
        )
        .where('isAnonymous', isEqualTo: false)
        .withConverter(
          fromFirestore: UnivhexPost.fromFirestore,
          toFirestore: (UnivhexPost post, _) => post.toFirestore(),
        )
        .orderBy('Datetime', descending: true)
        .get();
    final dataList = snapshot.docs.map((doc) => doc.data()).toList();
    final userunivhexPosts = dataList.map((data) => data).toList();
    debugPrint("Kullanıcı post sayiis:" + userunivhexPosts.length.toString());
    return userunivhexPosts;
  } catch (e) {
    debugPrint(e.toString());
    return [];
  }
}

Future<AppUser?> readUserfromDB(String? userId) async {
  try {
    final ref = FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .withConverter(
          fromFirestore: AppUser.fromFirestore,
          toFirestore: (AppUser user, _) => user.toFirestore(),
        );

    final docSnap = await ref.get();
    debugPrint("BUM");

    if (docSnap.exists) {
      final AppUser user = docSnap.data()!;
      debugPrint(user.hexPoints.toString());
      return user;
    }
    return null;
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

Future<List<UnivhexPost>> fetchFeed(String universityName) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('Posts')
        .where('University', isEqualTo: universityName.toLowerCase())
        .withConverter(
          fromFirestore: UnivhexPost.fromFirestore,
          toFirestore: (UnivhexPost post, _) => post.toFirestore(),
        )
        .orderBy('Datetime', descending: true)
        .get();
    final dataList = snapshot.docs.map((doc) => doc.data()).toList();
    final univhexPosts = dataList.map((data) => data).toList();

    return univhexPosts;
  } catch (e) {
    debugPrint(e.toString());
    return [];
  }
}

Future<List<UnivhexPost>> fetchUnivhexes(String universityName) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('Posts')
        .where('University',
            isEqualTo: universityName.toLowerCase()) // error generated here
        .where('isAnonymous', isEqualTo: false)
        .withConverter(
          fromFirestore: UnivhexPost.fromFirestore,
          toFirestore: (UnivhexPost post, _) => post.toFirestore(),
        )
        .orderBy('HexCount', descending: true)
        .limit(3)
        .get();
    final dataList = snapshot.docs.map((doc) => doc.data()).toList();
    final univhexPosts = dataList.map((data) => data).toList();

    return univhexPosts;
  } catch (e) {
    debugPrint(e.toString());
    return [];
  }
}
