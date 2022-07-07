import 'package:flutter/material.dart';
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
    );
  }
}
