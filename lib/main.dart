import 'package:ecommerceapp/provider/cart.dart';
import 'package:ecommerceapp/provider/inventory.dart';
import 'package:ecommerceapp/provider/order.dart';
import 'package:ecommerceapp/screen/cart_page.dart';
import 'package:ecommerceapp/screen/edit_account_page.dart';
import 'package:ecommerceapp/screen/inventory_page.dart';
import 'package:ecommerceapp/screen/order_details_page.dart';
import 'package:ecommerceapp/screen/sign_in_page.dart';
import 'package:ecommerceapp/screen/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import './screen/home_page.dart';
import 'provider/products.dart';
import 'package:provider/provider.dart';
import './screen/product_details_page.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
        ChangeNotifierProvider.value(
          value: InventoryProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'E-commerce App',
        theme: ThemeData(
            primarySwatch: Colors.amber,
            primaryColor: Colors.amber,
            secondaryHeaderColor: Colors.amber),
        home: SignInScreen(),
        routes: {
          ProductDetail.routeName: (context) => const ProductDetail(),
          CartPage.routeName: (context) => const CartPage(),
          InventoryPage.routeName: (context) => const InventoryPage(),
          OrderDetailsPage.routeName: (context) => const OrderDetailsPage(),
          EditAccountPage.routeName: (context) => const EditAccountPage()
        },
      ),
    );
  }
}
