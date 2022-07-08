import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/provider/order.dart';
import 'package:ecommerceapp/screen/order_details_page.dart';
import 'package:ecommerceapp/widget/reusables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart' show Cart;
import '../widget/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  static const routeName = '/cart_page';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: cart.items.length,
              itemBuilder: (context, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].imgurl,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Amount  ",
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "₹ ${cart.totalAmount.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(
                          fontSize: 25, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    if (cart.items.isNotEmpty) {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(), cart.totalAmount);
                      cart.clear();

                      Navigator.of(context).pushNamed(
                        OrderDetailsPage.routeName,
                      );
                    } else {
                      displaySnackBar(
                          text: 'Please add atleast one item',
                          context: context);
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(
                        //     // color: Colors.amberAccent,
                        //     ),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Text(
                      'Place Order',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
