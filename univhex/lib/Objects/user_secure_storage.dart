import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:univhex/Objects/app_user.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _keyFirebaseUID = "uid";
  static const _keyUser = "user";
  static const _keyEmail = "email";
  static const _keyPassword = "password";

  static Future<String?> getEmail() async {
    return _storage.read(key: "email");
  }

  static Future<String?> getFirebaseUID() async {
    return _storage.read(key: "uid");
  }

  static Future<bool> setEmail(String email) async {
    try {
      await _storage.write(key: _keyEmail, value: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> getPassword() async {
    return _storage.read(key: "password");
  }

  static Future<bool> setPassword(String password) async {
    try {
      await _storage.write(key: _keyPassword, value: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<AppUser?> getUser() async {
    return AppUser.deserialize(await _storage.read(key: _keyUser));
  }

  static Future<bool> setUser(AppUser user) async {
    try {
      await _storage.write(key: _keyUser, value: AppUser.serialize(user));
      await _storage.write(key: _keyEmail, value: user.email);
      await _storage.write(key: _keyPassword, value: user.password);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool?> setFirebaseUID(String UID) async {
    try {
      await _storage.write(key: _keyFirebaseUID, value: UID);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteStorage() async {
    try {
      await _storage.delete(key: _keyFirebaseUID);
      await _storage.delete(key: _keyUser);
      await _storage.delete(key: _keyEmail);
      await _storage.delete(key: _keyPassword);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
