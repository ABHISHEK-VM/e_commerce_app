import 'package:ecommerceapp/screen/product_details_page.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgurl;

  ProductItem(this.id, this.title, this.imgurl);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.shopping_cart_rounded),
          onPressed: () {},
        ),
        title: Text(title),
        trailing: IconButton(
          icon: const Icon(Icons.catching_pokemon_sharp),
          onPressed: () {},
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetail.routeName,
            arguments: title,
          );
        },
        child: Image.network(
          imgurl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
