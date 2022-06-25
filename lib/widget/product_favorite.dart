import 'package:flutter/material.dart';
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

    return showFavs
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
        : Container();
  }
}
