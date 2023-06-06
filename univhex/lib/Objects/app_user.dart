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
  final String? password;
  final String? university;
  final String? fieldOfStudy;
  final String? yearOfStudy;
  String? imgUrl = "";
  final int? hexPoints;

  String hashPassword(String password) {
    final bytes = utf8.encode(password); // Convert the password to bytes
    final digest = sha256.convert(bytes); // Hash the bytes using SHA-256

    // Return the hashed password as a hexadecimal string
    return digest.toString();
  }

  ImageProvider<Object> getImageProvider() {
    return imgUrl == 'assets/images/icon.png'
        ? const AssetImage('assets/images/icon.png')
        : NetworkImage(imgUrl!) as ImageProvider;
    ;
  }

  bool verifyPassword(String enteredPassword, String hashedPassword) {
    final enteredPasswordHash = hashPassword(enteredPassword);

    // Compare the stored hashed password with the entered password hash
    return enteredPasswordHash == hashedPassword;
  }

  String camelAttr(String x) {
    List strSplit = x.split(" ");
    String result = "";
    for (int i = 0; i < strSplit.length; i++) {
      String str = strSplit[i];

      result += str.substring(0, 1).toUpperCase() + str.substring(1);
      if (i < strSplit.length - 1) {
        result += " ";
      }
    }
    return result;
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
    this.imgUrl,
    this.hexPoints,
  });

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
      imgUrl: jsonData["ImgUrl"],
      hexPoints: jsonData["HexPoints"],
    );
  }

  Map<String, dynamic> toFirestore() {
    final hashedPassword = hashPassword(password!);

    return {
      "id": id,
      "Name": name,
      "Surname": surname,
      "Email": email,
      "Password": hashedPassword,
      "University": university,
      "FieldOfStudy": fieldOfStudy,
      "YearOfStudy": yearOfStudy,
      "ImgUrl": imgUrl,
      "HexPoints": hexPoints,
    };
  }

  @override
  String toString() {
    return ("ID: $id, Name: $name\nSurname: $surname\nemail: $email\npassword: $password\nUniversity: $university\nField: $fieldOfStudy\nyearOfStudy: $yearOfStudy");
  }
}
