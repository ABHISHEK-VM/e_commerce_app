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

  // Future<void> getUser(String id) async {
  //   try {
  //     final result = await _cloud
  //         .collection("userdata")
  //         .where('id', isEqualTo: id)
  //         .get();

  //     final details = result.docs.first.data();

  //     _account = Account(
  //       name: details["name"],
  //       address: details["address"],
  //       email: details["email"],
  //       phone: details["phone"],
  //     );
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> checkUser({required String email, required bool isLogin}) async {
  //   try {
  //     final result = await _cloud
  //         .collection("userdata")
  //         .where('email', isEqualTo: email)
  //         .get();

  //     print('email from firebaes : $result');

  //     if (result.docs.isNotEmpty) {
  //       if (isLogin) {
  //         final details = result.docs.first.data();

  //         _account = Account(
  //           name: details["name"],
  //           address: details["address"],
  //           email: details["email"],
  //           phone: details["phone"],
  //         );
  //       }
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> registeredUser(Account account) async {
  //   try {
  //     final data = {
  //       "name": account.name,
  //       "email": account.email,
  //       "address": account.address,
  //       "phone": account.phone,
  //     };

  //     final details = await _cloud.collection('userdata').add(data);

  //     account.id = details.id;
  //     _account = account;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // List<Account> _accountDetails = [];
  // QuerySnapshot value = await _cloud.collection("userdata").get();

  // for (var element in value.docs) {
  //   var account = Account(
  //     id: element.get("id"),
  //     name: element.get("name"),
  //     address: element.get("address"),
  //     email: element.get("email"),
  //     phone: element.get("phone"),
  //   );

  //   _accountDetails.add(account);
  // }

  // _datas = _accountDetails;
  // print('new details : $_datas');
  // notifyListeners();
}

  // List<Account> get datas {
  //   return [..._datas];
  // }

