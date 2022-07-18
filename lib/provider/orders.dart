import 'package:ecommerceapp/model/cart_model.dart';
import 'package:flutter/foundation.dart';

import '../widget/order_item.dart';

class Order {
  final String id;
  final double amount;
  List<OrderItem> orderItems;
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

  void addOrder(Order order, double total) async {
    try {
      List<Map<String, dynamic>> orderItems = [];

      order.orderItems.forEach((element) {
// orderItems.add({"id": element.id,
// "title":element.t
// });
      });
    } catch (e) {}

    // _orders.insert(
    //   0,
    //   OrderItem(
    //     id: DateTime.now().toString(),
    //     amount: total,
    //     dateTime: DateTime.now(),
    //     products: cartProducts,
    //   ),
    // );
    notifyListeners();
  }
}
