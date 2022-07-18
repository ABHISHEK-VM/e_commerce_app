import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../provider/products.dart';
import './product_item.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    final productsdata = Provider.of<Products>(context);
    final products = productsdata.items;
    print('products : ${products}');

    RefreshController _refreshController = RefreshController();

    Future refreshData() async {
      await Future.delayed(const Duration(seconds: 1));
      final productsdata =
          await Provider.of<Products>((context), listen: false).getInventory();
      setState(() {
        _refreshController.refreshCompleted();
      });
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: products.isNotEmpty
          ? SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropHeader(
                waterDropColor: Color.fromARGB(255, 13, 138, 241),
              ),
              onRefresh: refreshData,
              child: GridView.builder(
                itemCount: products.length,
                itemBuilder: (context, i) => ChangeNotifierProvider.value(
                  value: products[i],
                  child: const ProductItem(),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 7 / 8,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
              ),
            )
          : Center(
              child: Text(
                'No items to display...',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey),
              ),
            ),
    );
  }
}
