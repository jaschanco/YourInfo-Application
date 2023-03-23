// ignore_for_file: avoid_print, avoid_web_libraries_in_flutter, file_names
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:information_display/services/authService.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import 'userModel.dart';

class Storage{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final AuthService test = AuthService();

  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);
    try{
      await storage.ref('${firebaseAuth.currentUser!.uid}/uploads/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e){
      print(e);
    }
  }

  Future addUserInfoToDB(String userId, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
      .collection("users")
      .doc(userId)
      .set(userInfoMap);
  }

  Future <Profile> updateProfileData(String userID, Profile profile) async {
    final dbClient = FirebaseFirestore.instance.collection('user')
        .doc(userID);

    await dbClient.update(profile.toJson());
    return profile;
  }

  Future getUserFromDB(String userId) {
    return FirebaseFirestore.instance.collection("users").doc(userId).get();
  }

  Future<firebase_storage.ListResult> listFiles()async{
    firebase_storage.ListResult result = await storage.ref('jachin').listAll();

    return result;
  }

  Stream<String> getPicStream(String imageName) {
    return storage.ref('${firebaseAuth.currentUser!.uid}/uploads/$imageName').getDownloadURL().asStream();
  }

  Future<String> getPic (String imageName)async{
    String downloadURL = await storage.ref('${firebaseAuth.currentUser!.uid}/uploads/$imageName').getDownloadURL();
    return downloadURL;
  }

}