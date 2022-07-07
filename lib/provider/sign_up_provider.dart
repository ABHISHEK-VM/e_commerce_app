import 'package:ecommerceapp/widget/reusables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);

  Future<void> signUpWithEmail({
    required String name,
    required String email,
    required String password,
    required String address,
    required String phone,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      displaySnackBar(text: e.message.toString(), context: context);
    }
  }
}
