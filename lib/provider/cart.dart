import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imgurl;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imgurl,
  });
}

class Cart with ChangeNotifier {
  final _cloud = FirebaseFirestore.instance;

  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  // List<CartItem> _cartitems = [];
  late CartItem cartItem;

  int? get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
    String imgurl,
    int quantity,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price,
              imgurl: existingCartItem.imgurl));
      FirebaseFirestore.instance
          .collection("cart")
          .doc()
          .update({"quantity": quantity + 1});
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price,
              imgurl: imgurl));

      Map<String, dynamic> cartItem = {
        "id": DateTime.now().toString(),
        "title": title,
        " quantity": 1,
        "price": price,
        "imgurl": imgurl,
      };
      FirebaseFirestore.instance.collection("cart").add(cartItem);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  Future<void> getCartItem() async {
    List<CartItem> _newcartitems = [];
    QuerySnapshot value = await _cloud.collection("cart").get();

    value.docs.forEach((element) {
      var cartItem = CartItem(
        id: element.get("id"),
        imgurl: element.get("imageurl"),
        title: element.get("title"),
        quantity: element.get("quantity"),
        price: element.get("price"),
      );

      _newcartitems.add(cartItem);
    });

    _items = _newcartitems as Map<String, CartItem>;
    print('new cart items : ${_items}');
    //print(' items id: ${_newitems.id}');
    notifyListeners();
  }

  // List<CartItem> get cartitems {
  //   return [..._cartitems];
  // }
}
