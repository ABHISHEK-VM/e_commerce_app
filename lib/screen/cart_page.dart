import 'package:ecommerceapp/database/db_helper.dart';
import 'package:ecommerceapp/model/cart_model.dart';
import 'package:ecommerceapp/provider/cartProvider.dart';
import 'package:ecommerceapp/provider/order.dart';
import 'package:ecommerceapp/screen/order_details_page.dart';
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
                  return const Expanded(
                    child: Center(
                      child: Text('Cart is empty'),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snaphot.data!.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            // clipBehavior: Clip.antiAlias,
                            child: Card(
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
                                  children: [
                                    Image.network(
                                      snaphot.data![index].image.toString(),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topLeft,
                                      width: 95,
                                    ),
                                    const SizedBox(width: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            snaphot.data![index].title
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.openSans(
                                              color: const Color(0xFF1C1E2B),
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width <=
                                                      400
                                                  ? 18
                                                  : 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                          ),
                                          Text(
                                            snaphot.data![index].quantity
                                                .toString(),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                snaphot
                                                    .data![index].initialPrice
                                                    .toString(),
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete),
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
                                              Container(
                                                color: Colors.blue,
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(Icons
                                                          .remove_circle_outlined),
                                                      onPressed: () {
                                                        int quantity = snaphot
                                                            .data![index]
                                                            .quantity!;
                                                        double price = snaphot
                                                            .data![index]
                                                            .initialPrice!;
                                                        quantity--;
                                                        double? newPrice =
                                                            price * quantity;

                                                        if (quantity > 0) {
                                                          dbHelper!
                                                              .updateQuantity(
                                                                  Cart(
                                                            id: snaphot
                                                                .data![index]
                                                                .id!,
                                                            title: snaphot
                                                                .data![index]
                                                                .title!,
                                                            initialPrice: snaphot
                                                                .data![index]
                                                                .initialPrice!,
                                                            price: newPrice,
                                                            quantity: quantity,
                                                            image: snaphot
                                                                .data![index]
                                                                .image!,
                                                          ))
                                                              .then((value) {
                                                            newPrice = 0;
                                                            quantity = 0;
                                                            cart.removeTotalPrice(
                                                                double.parse(snaphot
                                                                    .data![
                                                                        index]
                                                                    .initialPrice!
                                                                    .toString()));
                                                          }).onError((error,
                                                                  stackTrace) {
                                                            print(error
                                                                .toString());
                                                          });
                                                        }
                                                      },
                                                    ),
                                                    Text(snaphot
                                                        .data![index].quantity
                                                        .toString()),
                                                    IconButton(
                                                      icon: const Icon(Icons
                                                          .add_circle_outlined),
                                                      onPressed: () {
                                                        int quantity = snaphot
                                                            .data![index]
                                                            .quantity!;

                                                        double price = snaphot
                                                            .data![index]
                                                            .initialPrice!;
                                                        quantity++;
                                                        double? newPrice =
                                                            price * quantity;

                                                        dbHelper!
                                                            .updateQuantity(
                                                                Cart(
                                                          id: snaphot
                                                              .data![index].id!,
                                                          title: snaphot
                                                              .data![index]
                                                              .title!,
                                                          initialPrice: snaphot
                                                              .data![index]
                                                              .initialPrice!,
                                                          price: newPrice,
                                                          quantity: quantity,
                                                          image: snaphot
                                                              .data![index]
                                                              .image!,
                                                        ))
                                                            .then((value) {
                                                          newPrice = 0;
                                                          quantity = 0;
                                                          cart.addTotalPrice(
                                                              double.parse(snaphot
                                                                  .data![index]
                                                                  .initialPrice!
                                                                  .toString()));
                                                        }).onError((error,
                                                                stackTrace) {
                                                          print(
                                                              error.toString());
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
                  if (cart.counter != 0) {
                    Provider.of<Orders>(context, listen: false)
                        .addOrder(cart.getData(), cart.getTotalPrice());

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