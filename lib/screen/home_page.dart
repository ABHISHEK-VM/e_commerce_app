import 'package:ecommerceapp/provider/products.dart';
import 'package:ecommerceapp/screen/edit_account_page.dart';
import 'package:ecommerceapp/screen/inventory_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../provider/cart.dart';
import '../widget/product_favorite.dart';
import '../widget/product_grid.dart';
import 'package:provider/provider.dart';

import 'package:badges/badges.dart';

import 'cart_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

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
    Products productsdata = Provider.of(context, listen: false);
    productsdata.getInventory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Account'),
              onTap: () {
                Navigator.pop(context);

                Navigator.of(context).pushNamed(
                  EditAccountPage.routeName,
                );
              },
            ),
            ListTile(
              title: const Text('Add Inventory'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(
                  InventoryPage.routeName,
                );
              },
            ),
            ListTile(
              title: const Text('My Orders'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'E-Commerce App',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 19),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
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
                child: const Icon(
                  Icons.shopping_cart,
                  size: 26,
                ),
              ),
            ),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[600],
        onTap: _onItemTapped,
      ),
    );
  }
}
