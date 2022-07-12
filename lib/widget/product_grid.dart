import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';
import './product_item.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsdata = Provider.of<Products>(context);
    final products = productsdata.items;
    print('products : ${products}');

    return Padding(
      padding: const EdgeInsets.all(8),
      child: products.isNotEmpty
          ? GridView.builder(
              itemCount: products.length,
              itemBuilder: (context, i) => ChangeNotifierProvider.value(
                value: products[i],
                child: const ProductItem(),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 7 / 8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
            )
          : Center(
              child: Text(
                'No items to display...',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey),
              ),
            ),
    );
  }
}
