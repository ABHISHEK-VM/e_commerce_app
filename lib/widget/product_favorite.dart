import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import './product_item.dart';
import '../provider/products.dart';

class ProductFavorite extends StatelessWidget {
  final bool showFavs;
  const ProductFavorite(this.showFavs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context);
    final products = productsContainer.favorite;
    // print(productscontainer.showFavorite());

    return products.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(8),
            child: GridView.builder(
              itemCount: products.length,
              itemBuilder: (context, i) => ChangeNotifierProvider.value(
                value: products[i],
                child: const ProductItem(),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5 / 6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
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
          );
  }
}
