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
    return GridView.builder(
      itemCount: products.length,
      itemBuilder: (context, i) => ProductItem(
        products[i].id,
        products[i].title,
        products[i].imgurl,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
