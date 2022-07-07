import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../provider/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  String id;
  final double price;
  final int quantity;
  final String productId;
  final String title;
  final String imgurl;

  CartItem(this.id, this.productId, this.title, this.price, this.quantity,
      this.imgurl);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(id),
      margin: const EdgeInsets.all(15),
      elevation: 2.0,
      shadowColor: Colors.grey[100],
      child: SizedBox(
        height: 135,
        width: double.infinity,
        child: Row(
          children: [
            Image.network(
              imgurl,
              fit: BoxFit.contain,
              alignment: Alignment.topLeft,
              width: 95,
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.openSans(
                      color: const Color(0xFF1C1E2B),
                      fontSize:
                          MediaQuery.of(context).size.width <= 400 ? 18 : 25,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                  Text(
                    quantity.toString(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price.toString(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          Provider.of<Cart>(context, listen: false)
                              .removeItem(productId);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
