import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:univhex/Constants/current_user.dart';
import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Objects/user_secure_storage.dart';

import 'firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
Duration loginTime = const Duration(milliseconds: 1600);

String _hashPassword(password) {
  var bytes = utf8.encode(password!);
  var hash = sha256.convert(bytes).toString();
  return hash;
}

Future<bool> registerUser(AppUser user) async {
  debugPrint('Sign-Up Name: ${user.email}, Password: ${user.password}');
  try {
    await _auth.createUserWithEmailAndPassword(
        email: user.email!, password: _hashPassword(user.password));
    user.id = _auth.currentUser!.uid;
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
  debugPrint("Auth\nEmail $email Password: $password");
  if (email == null || password == null) {
    return false;
  }
  try {
    await _auth.signInWithEmailAndPassword(
        email: email, password: _hashPassword(password));
    await Future.delayed(loginTime);
    await UserSecureStorage.setEmail(email);
    await UserSecureStorage.setPassword(password);
    await UserSecureStorage.setFirebaseUID(_auth.currentUser!.uid);
    debugPrint("şifre setlendi");
    CurrentUser.firebaseUser = _auth.currentUser;
    return true;
  } catch (e) {
    debugPrint("Error");
    debugPrint(e.toString());
    return false;
  }
}
