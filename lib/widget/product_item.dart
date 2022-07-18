import 'package:cached_network_image/cached_network_image.dart';
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
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          trailing: Consumer<Product>(
            builder: (context, value, _) => IconButton(
              icon: Icon(
                product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: const Color.fromARGB(255, 7, 112, 199),
              ),
              onPressed: () {
                product.toggleFavorite();
              },
            ),
          ),
          title: Consumer<Product>(
              builder: (context, value, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 0, 5, 18)),
                      ),
                      Text(
                        '₹ ${product.price.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color.fromARGB(255, 7, 112, 199),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetail.routeName,
              arguments: product.id,
            );
          },
          child: CachedNetworkImage(
            imageUrl: product.imgurl,
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) => Container(
              height: MediaQuery.of(context).size.height * .28,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Image.asset(
              "images/place_holder.png",
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * .28,
            ),
            // placeholder: (context, url) => loader(context),
          ),
        ),
      ),
    );
  }
}
