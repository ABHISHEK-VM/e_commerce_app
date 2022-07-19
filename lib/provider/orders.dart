import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/model/cart_model.dart';
import 'package:ecommerceapp/provider/order_items.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../widget/order_item.dart';

class Order {
  final String id;
  final double amount;
  Future<List<OrderItem>> orderItems;
  final DateTime dateTime;

  Order({
    required this.id,
    required this.amount,
    required this.orderItems,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  // Future<String> addOrder(Order order, double total, String customerId) async {
  //   try {
  //     List<Map<String, dynamic>> orderItems = [];

  //     order.orderItems.forEach((element) {

  //       orderItems.add({

  //         "id": element.id,
  //         "title": element.title,
  //         "price": element.price,
  //         "image": element.image
  //       });

  //     });

  //     Map<String, dynamic> orderMap = {
  //       "orderItem": orderItems,
  //       "customerId": customerId,
  //       "totalAmount": total,
  //     };
  //     await FirebaseFirestore.instance.collection('order').add(orderMap);
  //   } catch (e) {}

  //   // _orders.insert(
  //   //   0,
  //   //   OrderItem(
  //   //     id: DateTime.now().toString(),
  //   //     amount: total,
  //   //     dateTime: DateTime.now(),
  //   //     products: cartProducts,
  //   //   ),
  //   // );
  //   notifyListeners();
  // }
}
