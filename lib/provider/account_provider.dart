import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/provider/account.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AccountProvider with ChangeNotifier {
  final _cloud = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Account? account;

  List<Map<String, dynamic>> _emails = [];

  List<Map<String, dynamic>> get emails {
    return _emails;
  }

  List<Account> _datas = [];

  Future<void> getAccountDetails() async {
    List<Account> _accountDetails = [];
    QuerySnapshot value = await _cloud.collection("userdata").get();

    for (var element in value.docs) {
      var account = Account(
        id: element.get("id"),
        name: element.get("name"),
        address: element.get("address"),
        email: element.get("email"),
        phone: element.get("phone"),
      );

      _accountDetails.add(account);
    }

    _datas = _accountDetails;
    print('new details : $_datas');
    notifyListeners();
  }

  List<Account> get datas {
    return [..._datas];
  }
}
