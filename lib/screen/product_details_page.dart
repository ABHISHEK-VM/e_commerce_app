import 'package:ecommerceapp/widget/reusables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import '../provider/products.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);

  static const routeName = '/product_details_page';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String?;

    final cart = Provider.of<Cart>(context, listen: false);

    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId!);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromARGB(255, 3, 0, 14),
                  Color.fromARGB(255, 2, 32, 57),
                  Color.fromARGB(255, 6, 63, 109),
                  Color.fromARGB(255, 19, 109, 182),
                  Colors.blue
                ]),
          ),
        ),
        title: Text(
          loadedProduct.title,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 19, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(9),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    // CachedNetworkImage(

                    //   fit: BoxFit.cover,
                    //   imageBuilder: (context, imageProvider) => Container(
                    //     height: MediaQuery.of(context).size.height * .28,
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.rectangle,
                    //       image: DecorationImage(
                    //           image: imageProvider, fit: BoxFit.cover),
                    //     ),
                    //   ),
                    //   imageUrl:
                    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
                    //   progressIndicatorBuilder:
                    //       (context, url, downloadProgress) =>
                    //           CircularProgressIndicator(
                    //               value: downloadProgress.progress),
                    //   errorWidget: (context, url, error) =>
                    //       const Icon(Icons.error),

                    // ),

                    Container(
                      height: MediaQuery.of(context).size.height * .28,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: NetworkImage(loadedProduct.imgurl),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 8, 17, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .67,
                                child: Text(
                                  '₹ ${loadedProduct.price.toString()}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Description',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 11),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 18,
                          right: 18,
                          top: 18,
                          bottom: 18,
                        ),
                        child: SizedBox(
                            width: double.infinity,
                            child: Text(loadedProduct.description,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500))),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 54,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Color.fromARGB(255, 9, 50, 85),
                            Color.fromARGB(255, 19, 109, 182),
                            Colors.blue
                          ]),
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  // padding:
                  //     const EdgeInsets.symmetric(vertical: 13, horizontal: 100),
                  child: Text(
                    'Buy Now',
                    style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  cart.addItem(loadedProduct.id!, loadedProduct.price,
                      loadedProduct.title, loadedProduct.imgurl, 1);

                  displaySnackBar(
                      context: context, text: 'Product added to Cart...');
                },
                child: Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 54,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2.5,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                    child: Container(
                      child: Text(
                        'Add to Cart',
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
