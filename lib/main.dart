import 'package:ecommerceapp/provider/cart.dart';
import 'package:ecommerceapp/screen/cart_page.dart';
import 'package:flutter/material.dart';
import './screen/home_page.dart';
import 'provider/products.dart';
import 'package:provider/provider.dart';
import './screen/product_details_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'E-commerce App',
        theme: ThemeData(
            primarySwatch: Colors.amber,
            primaryColor: Colors.amber,
            secondaryHeaderColor: Colors.amber),
        home: HomePage(),
        routes: {
          ProductDetail.routeName: (context) => const ProductDetail(),
          CartPage.routeName: (context) => const CartPage(),
        },
      ),
    );
  }
}
