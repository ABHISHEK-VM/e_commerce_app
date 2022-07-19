import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/database/db_helper.dart';
import 'package:ecommerceapp/model/cart_model.dart';
import 'package:ecommerceapp/provider/cartProvider.dart';
import 'package:ecommerceapp/provider/orders.dart';
import 'package:ecommerceapp/screen/order_details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widget/reusables.dart';

class CartPage extends StatefulWidget {
  static const routeName = '/cart_page';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  DBHelper? dbHelper = DBHelper();

  final userId = FirebaseAuth.instance.currentUser!.uid;

  late Order _cart;
  bool _isLoading = true;

  void placeOrder() {}

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Column(
      children: [
        FutureBuilder(
            future: cart.getData(),
            builder: (context, AsyncSnapshot<List<Cart>> snaphot) {
              if (snaphot.hasData) {
                if (snaphot.data!.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'Cart is empty',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snaphot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                              // side: BorderSide(
                              //     width: 2,
                              //     color: Color.fromARGB(255, 3, 90, 130)),
                            ),
                            clipBehavior: Clip.antiAlias,
                            margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                            elevation: 5.0,
                            // color: Colors.red,
                            shadowColor:
                                const Color.fromARGB(255, 250, 250, 250),
                            child: SizedBox(
                              // height: 139,
                              width: double.infinity,
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: snaphot.data![index].image!,
                                    fit: BoxFit.cover,
                                    imageBuilder: (context, imageProvider) =>
                                        Image.network(
                                      snaphot.data![index].image!,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topLeft,
                                      width: 106,
                                    ),
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                  // CachedNetworkImage(
                                  //   imageUrl: snaphot.data![index].image!,
                                  //   fit: BoxFit.cover,
                                  //   imageBuilder: (context, imageProvider) =>
                                  //       Container(
                                  //     height:
                                  //         MediaQuery.of(context).size.height *
                                  //             .28,
                                  //     decoration: BoxDecoration(
                                  //       shape: BoxShape.rectangle,
                                  //       image: DecorationImage(
                                  //           image: imageProvider,
                                  //           fit: BoxFit.cover),
                                  //     ),
                                  //   ),
                                  //   progressIndicatorBuilder: (context, url,
                                  //           downloadProgress) =>
                                  //       CircularProgressIndicator(
                                  //           value: downloadProgress.progress),
                                  //   errorWidget: (context, url, error) =>
                                  //       const Icon(Icons.error),
                                  //   // placeholder: (context, url) => loader(context),
                                  // ),
                                  const SizedBox(width: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snaphot.data![index].title!,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'Qty : ${snaphot.data![index].quantity!}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              '₹ ${snaphot.data![index].initialPrice.toString()}',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromARGB(
                                                      255, 15, 118, 203)),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                size: 28,
                                                color: Color.fromARGB(
                                                    255, 208, 16, 44),
                                              ),
                                              onPressed: () {
                                                dbHelper!.delete(
                                                    snaphot.data![index].id!);
                                                cart.removeCounter();
                                                cart.removeTotalPrice(
                                                    double.parse(snaphot
                                                        .data![index].price
                                                        .toString()));
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 11),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.centerRight,
                                          end: Alignment.centerLeft,
                                          colors: <Color>[
                                            Color.fromARGB(255, 4, 61, 126),
                                            Color.fromARGB(255, 13, 97, 166),
                                            Color.fromARGB(255, 21, 123, 207),
                                            Color.fromARGB(255, 81, 166, 235),
                                          ]),

                                      // border: Border.all(
                                      //   width: 3,
                                      //   color:
                                      //       Color.fromARGB(255, 3, 50, 120),
                                      // ),
                                      // borderRadius: BorderRadius.all(
                                      //   Radius.circular(40),
                                      // ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                              Icons.add_circle_outlined,
                                              color: Colors.white,
                                              size: 32),
                                          onPressed: () {
                                            int quantity =
                                                snaphot.data![index].quantity!;

                                            double price = snaphot
                                                .data![index].initialPrice!;
                                            quantity++;
                                            double? newPrice = price * quantity;

                                            dbHelper!
                                                .updateQuantity(Cart(
                                              id: snaphot.data![index].id!,
                                              title:
                                                  snaphot.data![index].title!,
                                              initialPrice: snaphot
                                                  .data![index].initialPrice!,
                                              price: newPrice,
                                              quantity: quantity,
                                              image:
                                                  snaphot.data![index].image!,
                                            ))
                                                .then((value) {
                                              newPrice = 0;
                                              quantity = 0;
                                              cart.addTotalPrice(double.parse(
                                                  snaphot.data![index]
                                                      .initialPrice!
                                                      .toString()));
                                            }).onError((error, stackTrace) {
                                              print(error.toString());
                                            });
                                          },
                                        ),
                                        Text(
                                            snaphot.data![index].quantity
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white)),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.remove_circle_outlined,
                                            size: 32,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            int quantity =
                                                snaphot.data![index].quantity!;
                                            double price = snaphot
                                                .data![index].initialPrice!;
                                            quantity--;
                                            double? newPrice = price * quantity;

                                            if (quantity > 0) {
                                              dbHelper!
                                                  .updateQuantity(Cart(
                                                id: snaphot.data![index].id!,
                                                title:
                                                    snaphot.data![index].title!,
                                                initialPrice: snaphot
                                                    .data![index].initialPrice!,
                                                price: newPrice,
                                                quantity: quantity,
                                                image:
                                                    snaphot.data![index].image!,
                                              ))
                                                  .then((value) {
                                                newPrice = 0;
                                                quantity = 0;
                                                cart.removeTotalPrice(
                                                    double.parse(snaphot
                                                        .data![index]
                                                        .initialPrice!
                                                        .toString()));
                                              }).onError((error, stackTrace) {
                                                print(error.toString());
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                }
              }
              return Text('');
            }),
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[
                  Color.fromARGB(255, 3, 50, 105),
                  Color.fromARGB(255, 11, 82, 141),
                  Color.fromARGB(255, 14, 111, 190),
                  Colors.blue,
                ]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Amount  ",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Consumer<CartProvider>(builder: (context, value, child) {
                    return Text(
                      value.getTotalPrice().toStringAsFixed(2),
                      style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    );
                  })
                ],
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _isLoading = true;
                  });

                  // _cart = Order(
                  //   id: _cart.id,
                  //   amount: _cart.amount,
                  //   orderItems: _cart.orderItems,
                  //   dateTime: _cart.dateTime,
                  // );

                  if (cart.counter != 0) {
                    // Provider.of<Orders>(context, listen: false)
                    //     .addOrder(_cart, cart.getTotalPrice(), userId)
                    //     .then((value) {
                    //   if (value == null) {
                    //     setState(() {
                    //       _isLoading = false;
                    //     });
                    //   }
                    // });

                    Navigator.of(context).pushNamed(
                      OrderDetailsPage.routeName,
                      arguments: cart.getTotalPrice().toStringAsFixed(2),
                    );
                    //cart.clear();
                  } else {
                    displaySnackBar(
                        text: 'Please add atleast one item', context: context);
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(
                      //     // color: Colors.amberAccent,
                      //     ),
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Text(
                    'Place Order',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Column(
        //   children: [
        //     Expanded(
        //       child: ListView.builder(
        //         scrollDirection: Axis.vertical,
        //         itemCount: cart.items.length,
        //         itemBuilder: (context, i) => CartItem(
        //           cart.items.values.toList()[i].id,
        //           cart.items.keys.toList()[i],
        //           cart.items.values.toList()[i].title,
        //           cart.items.values.toList()[i].price,
        //           cart.items.values.toList()[i].quantity,
        //           cart.items.values.toList()[i].imgurl,
        //         ),
        //       ),
        //     ),
        //     Container(
        //       padding: const EdgeInsets.all(12),
        //       width: double.infinity,
        //       decoration: const BoxDecoration(
        //         gradient: LinearGradient(
        //             begin: Alignment.bottomCenter,
        //             end: Alignment.topCenter,
        //             colors: <Color>[
        //               Color.fromARGB(255, 3, 50, 105),
        //               Color.fromARGB(255, 11, 82, 141),
        //               Color.fromARGB(255, 14, 111, 190),
        //               Colors.blue,
        //             ]),
        //       ),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 "Total Amount  ",
        //                 style: GoogleFonts.poppins(
        //                     fontSize: 14,
        //                     fontWeight: FontWeight.w500,
        //                     color: Colors.white),
        //               ),
        //               Text(
        //                 "₹ ${cart.totalAmount.toStringAsFixed(2)}",
        //                 style: GoogleFonts.poppins(
        //                     fontSize: 25,
        //                     fontWeight: FontWeight.w800,
        //                     color: Colors.white),
        //               ),
        //             ],
        //           ),
        //           InkWell(
        //             onTap: () {
        //               if (cart.items.isNotEmpty) {
        //                 Provider.of<Orders>(context, listen: false).addOrder(
        //                     cart.items.values.toList(), cart.totalAmount);

        //                 Navigator.of(context).pushNamed(
        //                   OrderDetailsPage.routeName,
        //                   arguments: cart.totalAmount.toStringAsFixed(2),
        //                 );
        //                 cart.clear();
        //               } else {
        //                 displaySnackBar(
        //                     text: 'Please add atleast one item',
        //                     context: context);
        //               }
        //             },
        //             child: Container(
        //               decoration: const BoxDecoration(
        //                   color: Colors.white,
        //                   // border: Border.all(
        //                   //     // color: Colors.amberAccent,
        //                   //     ),
        //                   borderRadius: BorderRadius.all(Radius.circular(40))),
        //               padding: const EdgeInsets.symmetric(
        //                   vertical: 10, horizontal: 16),
        //               child: Text(
        //                 'Place Order',
        //                 style: GoogleFonts.poppins(
        //                   fontSize: 17,
        //                   fontWeight: FontWeight.w500,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],