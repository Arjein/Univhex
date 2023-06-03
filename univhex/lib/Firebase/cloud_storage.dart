import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/current_user.dart';
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
      postedBy: newPost.postedBy,
      university: newPost.university,
      textContent: newPost.textContent,
      isAnonymous: newPost.isAnonymous,
      dateTime: newPost.dateTime,
      hexedBy: newPost.hexedBy,
      comments: newPost.comments,
    );

    await newPostRef.set(updatedPost.toFirestore());

    return true;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}

Future<AppUser?> readUserfromDB(String email) async {
  try {
    debugPrint("Burdamı patliyor acaba?");
    final ref = FirebaseFirestore.instance
        .collection("Users")
        .where('Email', isEqualTo: email)
        .withConverter(
          fromFirestore: AppUser.fromFirestore,
          toFirestore: (AppUser user, _) => user.toFirestore(),
        );

    final docSnap = await ref.get();
    final queryLen = docSnap.docs.length;
    if (queryLen == 1) {
      final AppUser user = docSnap.docs.elementAt(0).data();
      debugPrint("Retrieved User: $user");
      return user;
    } else {
      return null;
    }
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

Future<UnivhexPost?> readPostfromDB(UnivhexPost post) async {
  try {
    final ref = FirebaseFirestore.instance
        .collection("Posts")
        .where('id', isEqualTo: post.id)
        .withConverter(
          fromFirestore: UnivhexPost.fromFirestore,
          toFirestore: (UnivhexPost post, _) => post.toFirestore(),
        );

    final docSnap = await ref.get();
    final queryLen = docSnap.docs.length;
    debugPrint(queryLen.toString());
    if (queryLen == 1) {
      final UnivhexPost post = docSnap.docs.elementAt(0).data();
      debugPrint("Retrieved Post: $post");
      return post;
    } else {
      return null;
    }
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

Future<List<UnivhexPost>> fetchFeed(String universityName) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('Posts')
        .where('University', isEqualTo: universityName) // error generated here
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
// Aşşağı calismiyo olabilir
Future<List<dynamic>> fetchPostCommentFeed(String postId) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .withConverter(
          fromFirestore: UnivhexPost.fromFirestore,
          toFirestore: (UnivhexPost post, _) => post.toFirestore(),
        )
        .get();

    UnivhexPost post = UnivhexPost.fromFirestore(
        snapshot.data() as DocumentSnapshot<Map<String, dynamic>>,
        Null as SnapshotOptions?);
    debugPrint(post.postedBy.toString());
    return [];
  } catch (e) {
    debugPrint(e.toString());
    return [];
  }
}



Stream<List<UnivhexPost>> fetchFeedStream() {
  return FirebaseFirestore.instance
      .collection('Posts')
      .withConverter(
        fromFirestore: UnivhexPost.fromFirestore,
        toFirestore: (UnivhexPost post, _) => post.toFirestore(),
      )
      .orderBy('Datetime', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
}
