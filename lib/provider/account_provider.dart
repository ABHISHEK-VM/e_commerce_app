import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/provider/account.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AccountProvider with ChangeNotifier {
  final _cloud = FirebaseFirestore.instance;

  Account? _account;

  Account? get account {
    return _account;
  }

  String name = '';
  String email = '';
  String address = '';
  String phone = '';

  Future getData() async {
    await _cloud
        .collection("userData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        name = snapshot.data()!["name"];
        email = snapshot.data()!["email"];
        address = snapshot.data()!["address"];
        phone = snapshot.data()!["phone"];
      }
    });
    _account = Account(
      name: name,
      address: address,
      email: email,
      phone: phone,
    );

    notifyListeners();
  }
}
