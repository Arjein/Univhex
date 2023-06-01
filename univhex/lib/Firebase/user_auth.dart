import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Objects/user_secure_storage.dart';

import 'cloud_storage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
Duration loginTime = const Duration(milliseconds: 1600);

Future<bool> registerUser(AppUser user) async {
  debugPrint('Sign-Up Name: ${user.email}, Password: ${user.password}');
  try {
    debugPrint("Email:" + user.email!);
    await _auth.createUserWithEmailAndPassword(
        email: user.email!, password: user.password!);
    await registerAppUserDB(user, _auth.currentUser!);
    await Future.delayed(loginTime);
    debugPrint("Registration Successful");
    return true;
  } catch (e) {
    debugPrint("_auth Error$e");
    return false;
  }
}

Future<bool> authUser(String? email, String? password) async {
  // Login olurken kullanıcı olup olmadığını kontrol et
  if (email == null || password == null) {
    return false;
  }
  try {
    /* Bu hash icin
    var bytes = utf8.encode(password);
    var hash = sha256.convert(bytes).toString(); 
    */
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    await Future.delayed(loginTime);
    UserSecureStorage.setFirebaseUID(_auth.currentUser!.uid);
    CurrentUser.firebaseUser = _auth.currentUser;
    return true;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}
