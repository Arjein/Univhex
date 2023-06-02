import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class AppUser {
  // User Object.
  String? id;
  final String? name;
  final String? surname;
  final String? email;
  String? password;
  final String? university;
  final String? fieldOfStudy;
  final String? yearOfStudy;
  String? imgURL;
  int? hexPoints = 0;
  // we might hash password
  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  AppUser({
    required this.id,
    this.name,
    this.surname,
    this.email,
    this.password,
    this.university,
    this.fieldOfStudy,
    this.yearOfStudy,
    this.hexPoints,
  });

  static String serialize(AppUser model) => json.encode(AppUser.toMap(model));

  static Map<String, dynamic> toMap(AppUser model) {
    return <String, dynamic>{
      "id": model.id,
      "Name": model.name,
      "Surname": model.surname,
      "Email": model.email,
      "Password": model.password,
      "University": model.university,
      "FieldOfStudy": model.fieldOfStudy,
      "YearOfStudy": model.yearOfStudy,
      "HexPoints": model.hexPoints,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> jsonData) {
    debugPrint("FROMJSON:\n${jsonData["Name"].runtimeType} ");
    return AppUser(
      id: jsonData["id"],
      name: jsonData["Name"],
      surname: jsonData["Surname"],
      email: jsonData["Email"],
      password: jsonData["Password"],
      university: jsonData["University"],
      fieldOfStudy: jsonData["FieldOfStudy"],
      yearOfStudy: jsonData["YearOfStudy"],
      hexPoints: jsonData["HexPoints"],
    );
  }

  static AppUser? deserialize(String? json) {
    if (json != null) {
      return AppUser.fromJson(jsonDecode(json));
    } else {
      return null;
    }
  }

  factory AppUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final jsonData = snapshot.data();
    return AppUser(
      id: snapshot.id,
      name: jsonData!["Name"],
      surname: jsonData["Surname"],
      email: jsonData["Email"],
      password: jsonData["Password"],
      university: jsonData["University"],
      fieldOfStudy: jsonData["FieldOfStudy"],
      yearOfStudy: jsonData["YearOfStudy"],
      hexPoints: jsonData["HexPoints"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "Name": name,
      "Surname": surname,
      "Email": email,
      "Password": password,
      "University": university,
      "FieldOfStudy": fieldOfStudy,
      "YearOfStudy": yearOfStudy,
      "HexPoints": hexPoints,
    };
  }

  @override
  String toString() {
    return ("ID: $id, Name: $name\nSurname: $surname\nemail: $email\npassword: $password\nUniversity: $university\nField: $fieldOfStudy\nyearOfStudy: $yearOfStudy");
  }
}
