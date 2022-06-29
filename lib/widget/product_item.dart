import 'package:ecommerceapp/screen/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../provider/product.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        footer: GridTileBar(
            backgroundColor: Colors.black.withOpacity(0.7),
            trailing: Consumer<Product>(
              builder: (context, value, _) => IconButton(
                icon: Icon(
                  product.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: Colors.amber,
                ),
                onPressed: () {
                  product.toggleFavorite();
                },
              ),
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w700),
                ),
                Text(
                  '₹ ${product.price.toString()}',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.amber,
                      fontWeight: FontWeight.w600),
                ),
              ],
            )),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetail.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imgurl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
