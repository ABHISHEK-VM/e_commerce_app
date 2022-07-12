import 'dart:ui';
import 'dart:convert';
import 'dart:io';

import 'package:ecommerceapp/provider/products.dart';
import 'package:ecommerceapp/screen/account_page.dart';
import 'package:ecommerceapp/screen/inventory_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../provider/cart.dart';
import '../widget/product_favorite.dart';
import '../widget/product_grid.dart';
import 'package:provider/provider.dart';

import 'package:badges/badges.dart';

import 'cart_page.dart';

import '../razor_credentials.dart' as razor_credentials;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  var _razorpay = Razorpay();

  static const List<Widget> _widgetOptions = <Widget>[
    ProductGrid(),
    ProductFavorite(true),
    CartPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    Products productsdata = Provider.of(context, listen: false);
    productsdata.getInventory();
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // final key = utf8.encode('rzp_test_ksf2yoBKbNmFu3');
    // final bytes = utf8.encode('$orderId|${response.paymentId}');

    // final hmacSha256 = Hmac(sha256, key);
    // final Digest generatedSignature = hmacSha256.convert(bytes);

    // if (generatedSignature.toString() == response.signature) {
    //   print("Payment was successful!");
    //   //Proceed further to handle events for a successful payment.
    // } else {
    //   print("Payment was unauthentic!");
    // }
    print("Payment Done");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(240, 247, 253, 255),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color.fromARGB(255, 3, 0, 14),
                      Color.fromARGB(255, 2, 32, 57),
                      Color.fromARGB(255, 6, 63, 109),
                      Color.fromARGB(255, 17, 107, 181),
                      Colors.blue
                    ]),
              ),
              child: Text(
                'Welcome',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 26),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.account_circle_outlined,
              ),
              title: const Text('Account'),
              onTap: () {
                Navigator.pop(context);

                Navigator.of(context).pushNamed(
                  AccountPage.routeName,
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.inventory_2_outlined),
              title: const Text('Add Inventory'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(
                  InventoryPage.routeName,
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              title: const Text('My Orders'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromARGB(255, 3, 0, 14),
                  Color.fromARGB(255, 2, 32, 57),
                  Color.fromARGB(255, 6, 63, 109),
                  Color.fromARGB(255, 19, 109, 182),
                  Colors.blue
                ]),
          ),
        ),
        title: Text(
          'GADSKart',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 19, color: Colors.white),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 70,

        // backgroundColor: Color.fromARGB(255, 2, 81, 149),
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              padding: const EdgeInsets.all(6),
              badgeContent: Consumer<Cart>(
                builder: ((_, cartData, ch) => Text(
                      cartData.itemCount.toString(),
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    )),
              ),
              child: const Icon(
                Icons.shopping_cart,
                size: 26,
              ),
            ),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 7, 104, 250),
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
