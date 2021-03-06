import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/widget/reusables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseAuthMethods {
  var profile = FirebaseFirestore.instance.collection('userData');

  Future<void> createUserData(String name, String email, String phone,
      String address, String uid) async {
    return await profile.doc(uid).set({
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
    });
  }
}




// class FirebaseAuthMethods {
//   final FirebaseAuth _auth;

//   FirebaseAuthMethods(this._auth);
//   final _cloud = FirebaseFirestore.instance;
//   Future<void> signUpWithEmail({
//     required String name,
//     required String email,
//     required String password,
//     required String address,
//     required String phone,
//     required BuildContext context,
//   }) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       displaySnackBar(text: e.message.toString(), context: context);
//     }
//   }
// }
