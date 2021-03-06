import 'package:ecommerceapp/provider/account_provider.dart';

import 'package:ecommerceapp/provider/cartProvider.dart';

import 'package:ecommerceapp/provider/inventory.dart';
import 'package:ecommerceapp/provider/orders.dart';
import 'package:ecommerceapp/screen/account_page.dart';
import 'package:ecommerceapp/screen/cart_page.dart';
import 'package:ecommerceapp/screen/edit_account_page.dart';
import 'package:ecommerceapp/screen/home_page.dart';
import 'package:ecommerceapp/screen/inventory_page.dart';
import 'package:ecommerceapp/screen/order_details_page.dart';
import 'package:ecommerceapp/screen/order_page.dart';
import 'package:ecommerceapp/screen/sign_in_page.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'provider/products.dart';
import 'package:provider/provider.dart';
import './screen/product_details_page.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('email');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: Products(),
      ),
      ChangeNotifierProvider.value(
        value: AccountProvider(),
      ),
      ChangeNotifierProvider.value(
        value: CartProvider(),
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
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        secondaryHeaderColor: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        duration: 4,
        splashIconSize: 240,
        // animationDuration: Duration(seconds: 1),
        splash: 'images/logo.png',
        nextScreen: email == null ? const SignInScreen() : HomePage(),
        splashTransition: SplashTransition.rotationTransition,
        animationDuration: Duration(seconds: 1),
        pageTransitionType: PageTransitionType.fade,
      ),
      routes: {
        HomePage.routeName: (context) => HomePage(),
        ProductDetail.routeName: (context) => ProductDetail(),
        CartPage.routeName: (context) => CartPage(),
        InventoryPage.routeName: (context) => const InventoryPage(),
        OrderDetailsPage.routeName: (context) => OrderDetailsPage(),
        AccountPage.routeName: (context) => const AccountPage(),
        EditAccountPage.routeName: (context) => const EditAccountPage(),
        SignInScreen.routeName: (context) => const SignInScreen(),
        OrderPage.routeName: (context) => OrderPage(),
      },
    ),
  ));
}
