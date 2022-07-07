import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Inventory {
  String id;
  String title;
  String description;
  double price;
  String imgurl;
  String imgId;

  Inventory(
      {required this.id,
      required this.description,
      required this.imgurl,
      required this.price,
      required this.title,
      required this.imgId});
}

class InventoryProvider with ChangeNotifier {
  final _cloud = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  // List<Inventory> _inventory = [];

  // List<Inventory> get inventory1 {
  //   return _inventory;
  // }

  Future<void> addInventory(Inventory inventory) async {
    try {
      List<Map<String, dynamic>> inventoryDetails = [];

      if (inventory.imgurl != "") {
        inventoryDetails.add({
          "title": inventory.title,
          "description": inventory.description,
          "price": inventory.price,
          "imgurl": inventory.imgurl,
          "imgId": inventory.imgId
        });
      }

      final data = {
        "title": inventory.title,
        "description": inventory.description,
        "price": inventory.price,
        "imgurl": inventory.imgurl,
        "imgId": inventory.imgId
      };
      final result = await _cloud.collection('inventory').add(data);

      notifyListeners();
      print(result);
    } catch (e) {
      print(e);
    }
  }
}
