class OrderItem {
  String id;
  String title;

  double price;
  int quantity;
  String image;

  OrderItem(
      {required this.id,
      required this.image,
      required this.price,
      required this.quantity,
      required this.title});

  List<OrderItem> orderItem(List<dynamic> data) {
    List<OrderItem> items = [];
    data.forEach((element) {
      items.add(OrderItem(
          id: element["id"],
          image: element["image"],
          price: element["price"],
          quantity: element["quantity"],
          title: element["title"]));
    });
    return items;
  }
}
