import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:univhex/Constants/current_user.dart';


// Upload the profile picture to Firebase Cloud Storage
Future<String> uploadProfilePicture(String userId, String imagePath) async {
  final Reference storageRef =
      FirebaseStorage.instance.ref().child('profile_pictures/$userId');
  final TaskSnapshot uploadTask = await storageRef.putFile(File(imagePath));
  final String downloadUrl = await uploadTask.ref.getDownloadURL();
  return downloadUrl;
}

// Save the profile picture URL to the user's profile in Firestore
void saveProfilePictureUrl(String userId, String profilePictureUrl) {
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('Users');
  CurrentUser.user!.imgUrl = profilePictureUrl;
  usersRef.doc(userId).update({'ImgUrl': profilePictureUrl});
}




