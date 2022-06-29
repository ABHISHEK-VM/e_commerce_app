// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// import '../widgets/Reusables.dart';
// import '../helpers/Enum.dart';
// import '../providers/OrderProvider.dart';
// import '../providers/VendorProvider.dart';
// import './DetailedOrderStatusPage.dart';

// class OrderStatusPage extends StatefulWidget {
//   static const routeName = '/_orderstatus';
//   @override
//   _OrderStatusPageState createState() => _OrderStatusPageState();
// }

// class _OrderStatusPageState extends State<OrderStatusPage> {
//   List<Order> _orderStatus = [];
//   bool _isLoading = false;
//   bool _isInit = true;
//   RefreshController _refreshController =
//       RefreshController(initialRefresh: false);

//   void _getOrders({OrderProvider orderProvider, bool isRefresh}) async {
//     if (!isRefresh) {
//       setState(() {
//         _isLoading = true;
//       });
//     }
//     final response = await orderProvider.getOrdersWithStatus(
//         Provider.of<VendorProvider>(context, listen: false).vendor.id);
//     if (response == ProviderResponse.Error) {
//       if (!isRefresh) {
//         setState(() {
//           _isLoading = false;
//         });
//       } else {
//         _refreshController.refreshFailed();
//       }
//       displaySnackBar(
//         context: context,
//         text:
//             'An unexpected error had occured while fetching orders, please check your internet connection or try again.',
//       );
//     } else {
//       if (!isRefresh) {
//         setState(() {
//           _isLoading = false;
//           _isInit = false;
//           _orderStatus = orderProvider.orderStatus;
//         });
//       } else {
//         _refreshController.refreshCompleted();
//         setState(() {
//           _orderStatus = orderProvider.orderStatus;
//         });
//       }
//     }
//   }

//   @override
//   void didChangeDependencies() async {
//     final orderProvider = Provider.of<OrderProvider>(context, listen: false);
//     if (_isInit && orderProvider.orderStatus.isEmpty) {
//       _getOrders(orderProvider: orderProvider, isRefresh: false);
//     }
//     setState(() {
//       _orderStatus = orderProvider.orderStatus;
//     });
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appbar(
//         child: Text(
//           'ORDER STATUS',
//           style: GoogleFonts.roboto(
//             color: Colors.white,
//             fontSize: MediaQuery.of(context).size.width > 390 ? 20 : 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//       backgroundColor: Theme.of(context).primaryColor,
//       body: _isLoading
//           ? loader(context)
//           : SmartRefresher(
//               controller: _refreshController,
//               enablePullDown: true,
//               header: WaterDropHeader(
//                 waterDropColor: Theme.of(context).accentColor,
//                 refresh: refreshLoader(context),
//               ),
//               onRefresh: () {
//                 _getOrders(
//                     isRefresh: true,
//                     orderProvider:
//                         Provider.of<OrderProvider>(context, listen: false));
//               },
//               child: Card(
//                 color: Colors.white,
//                 margin: EdgeInsets.only(top: 8),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                 ),
//                 child: Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.all(10),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(
//                           top: 10,
//                           bottom: 10,
//                           left: 0,
//                           right: 0,
//                         ),
//                         child: Text(
//                           '${_orderStatus.length} Order Requests to Manage',
//                           style: GoogleFonts.openSans(
//                             color: Theme.of(context).hintColor,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: ListView.builder(
//                           scrollDirection: Axis.vertical,
//                           itemCount: _orderStatus.length,
//                           itemBuilder: (context, index) {
//                             return GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context)
//                                     .pushNamed(
//                                         DetailedOrderStatusPage.routeName,
//                                         arguments: _orderStatus[index])
//                                     .then((value) => didChangeDependencies());
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     top: 1.0, bottom: 2.0),
//                                 child: Card(
//                                   elevation: 2.0,
//                                   shadowColor: Colors.grey[100],
//                                   child: Container(
//                                     height: 135,
//                                     width: double.infinity,
//                                     child: Row(
//                                       children: [
//                                         _orderStatus[index].customer.imageUrl ==
//                                                 ''
//                                             ? Image.asset(
//                                                 'assets/CustomerImagePlaceholder.jpg',
//                                                 width: 95,
//                                               )
//                                             : CachedNetworkImage(
//                                                 fit: BoxFit.contain,
//                                                 alignment: Alignment.topLeft,
//                                                 width: 95,
//                                                 imageUrl: _orderStatus[index]
//                                                     .customer
//                                                     .imageUrl,
//                                                 placeholder: (context, url) =>
//                                                     Image.asset(
//                                                   'assets/LoadingPlaceholder.jpg',
//                                                 ),
//                                                 errorWidget:
//                                                     (context, url, error) =>
//                                                         Container(
//                                                   color: Theme.of(context)
//                                                       .primaryColor,
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       Icon(
//                                                         Icons.error,
//                                                         color: Colors.white,
//                                                       ),
//                                                       SizedBox(
//                                                         width: 95,
//                                                         child: Text(
//                                                           'Failed to load image',
//                                                           textAlign:
//                                                               TextAlign.center,
//                                                           style: TextStyle(
//                                                             color: Colors.white,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                         SizedBox(width: 10),
//                                         Padding(
//                                           padding: EdgeInsets.all(10),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceAround,
//                                             children: [
//                                               SizedBox(
//                                                 width: MediaQuery.of(context)
//                                                             .size
//                                                             .width <=
//                                                         400
//                                                     ? MediaQuery.of(context)
//                                                             .size
//                                                             .width *
//                                                         0.4
//                                                     : MediaQuery.of(context)
//                                                             .size
//                                                             .width *
//                                                         0.6,
//                                                 child: Text(
//                                                   _orderStatus[index]
//                                                       .customer
//                                                       .name,
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   style: GoogleFonts.openSans(
//                                                     color: Color(0xFF1C1E2B),
//                                                     fontSize:
//                                                         MediaQuery.of(context)
//                                                                     .size
//                                                                     .width <=
//                                                                 400
//                                                             ? 18
//                                                             : 25,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                   maxLines: 2,
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: MediaQuery.of(context)
//                                                             .size
//                                                             .width <=
//                                                         400
//                                                     ? MediaQuery.of(context)
//                                                             .size
//                                                             .width *
//                                                         0.4
//                                                     : MediaQuery.of(context)
//                                                             .size
//                                                             .width *
//                                                         0.6,
//                                                 child: Text(
//                                                   orderStatusToString(
//                                                       _orderStatus[index]
//                                                           .status),
//                                                   style: GoogleFonts.openSans(
//                                                     color: _orderStatus[index]
//                                                                     .status ==
//                                                                 OrderStatus
//                                                                     .WaitingForPayment ||
//                                                             _orderStatus[index]
//                                                                     .status ==
//                                                                 OrderStatus
//                                                                     .Preparing
//                                                         ? Theme.of(context)
//                                                             .accentColor
//                                                         : Theme.of(context)
//                                                             .buttonColor,
//                                                     fontSize:
//                                                         MediaQuery.of(context)
//                                                                     .size
//                                                                     .width <=
//                                                                 400
//                                                             ? 13
//                                                             : 15,
//                                                     fontWeight: FontWeight.w600,
//                                                   ),
//                                                   softWrap: true,
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   maxLines: 2,
//                                                 ),
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Icon(
//                                                     _orderStatus[index].type ==
//                                                             OrderType.Pickup
//                                                         ? FontAwesomeIcons.car
//                                                         : FontAwesomeIcons
//                                                             .route,
//                                                   ),
//                                                   SizedBox(width: 5),
//                                                   Text(
//                                                     orderTypeToString(
//                                                         _orderStatus[index]
//                                                             .type),
//                                                     style: GoogleFonts.openSans(
//                                                         color: Theme.of(context)
//                                                             .hintColor,
//                                                         fontSize: 15,
//                                                         fontWeight:
//                                                             FontWeight.w600),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }