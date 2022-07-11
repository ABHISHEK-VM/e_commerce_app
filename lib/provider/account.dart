class Account {
  String? id;
  final String name;
  final String address;
  final String phone;
  final String email;

  Account(
      {this.id,
      required this.name,
      required this.address,
      required this.email,
      required this.phone});
}
