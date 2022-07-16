import 'package:flutter/material.dart';

class Cart {
  late final String? id;
  final String? title;
  final double? initialPrice;
  final double? price;
  final int? quantity;
  final String? image;

  Cart({
    required this.id,
    required this.title,
    required this.initialPrice,
    required this.price,
    required this.quantity,
    required this.image,
  });

  Cart.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        title = res["title"],
        price = res["price"],
        initialPrice = res["initialPrice"],
        quantity = res["quantity"],
        image = res["image"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'initialPrice': initialPrice,
      'price': price,
      'quantity': quantity,
      'image': image,
    };
  }
}
