import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Objects/app_user.dart';

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

Future<AppUser?> readUserfromDB(String email) async {
  try {
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