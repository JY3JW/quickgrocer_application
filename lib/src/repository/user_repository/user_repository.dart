import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_helper_utils/flutter_helper_utils.dart';
import 'package:get/get.dart';
import 'package:quickgrocer_application/src/features/authentication/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user, String? uid) async {
    await _db
        .collection("users")
        .doc(uid)
        .set(user.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your account has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green,
              duration: const Duration(seconds: 5)),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  createGoogleSignInUser(UserModel user, String? uid) async {
    await _db
        .collection("users")
        .doc(uid)
        .set(user.toJson())
        .whenComplete(() => {})
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  // Fetch single user details
  Future<UserModel> getUserDetails(String email) async {
    var snapshot =
        await _db.collection("users").where("email", isEqualTo: email).get();
    try {
      final userData =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
      return userData;
    } catch (e) {
      await createGoogleSignInUser(
          UserModel(
              email: FirebaseAuth.instance.currentUser?.email.isNotNull == true
                  ? FirebaseAuth.instance.currentUser?.email as String
                  : '',
              password:
                  FirebaseAuth.instance.currentUser?.phoneNumber.isNotNull ==
                          true
                      ? FirebaseAuth.instance.currentUser?.phoneNumber as String
                      : '',
              fullName:
                  FirebaseAuth.instance.currentUser?.displayName.isNotNull ==
                          true
                      ? FirebaseAuth.instance.currentUser?.displayName as String
                      : '',
              phoneNo:
                  FirebaseAuth.instance.currentUser?.phoneNumber.isNotNull ==
                          true
                      ? FirebaseAuth.instance.currentUser?.phoneNumber as String
                      : ''),
          FirebaseAuth.instance.currentUser?.uid);
      return getUserDetails(email);
    }
  }

  // Fetch all user details
  Future<List<UserModel>> allUsers() async {
    final snapshot = await _db.collection("users").get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<void> updateUserRecord(UserModel user, String? userId) async {
    await _db.collection("users").doc(userId).update(user.toJson());
  }

  Future<void> deleteUserRecord(String? uid) async {
    await _db.collection("users").doc(uid).delete();
  }
}
