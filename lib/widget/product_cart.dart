// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';
// import '../provider/cart.dart';

// class ProductCart extends StatelessWidget {
//   const ProductCart({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final productsCart = Provider.of<Cart>(context);
//     final products = productsCart.addItem;
//     return Padding(
//       padding: const EdgeInsets.all(8),
//       child: GridView.builder(
//         itemCount: products.itemCount,
//         itemBuilder: (context, i) => ChangeNotifierProvider.value(
//           value: products[i],
//           child: const ProductItem(),
//         ),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 5 / 6,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//         ),
//       ),
//     );
//   }
// }
