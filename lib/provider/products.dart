import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/provider/product.dart';

import 'package:flutter/material.dart';

class Products with ChangeNotifier {
  final _cloud = FirebaseFirestore.instance;

  List<Product> _items = [];
  late Product product;

  Future<void> getInventory() async {
    List<Product> _newitems = [];
    QuerySnapshot value = await _cloud.collection("inventory").get();

    for (var element in value.docs) {
      var product = Product(
        id: element.get("id"),
        imgurl: element.get("imageurl"),
        title: element.get("title"),
        description: element.get("description"),
        price: element.get("price"),
      );

      _newitems.add(product);
    }

    _items = _newitems;
    print('new items : ${_newitems}');
    //print(' items id: ${_newitems.id}');
    notifyListeners();
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favorite {
    return _items.where((proditem) => proditem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
