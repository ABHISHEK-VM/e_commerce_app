// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:http/http.dart' as http;
// import '../razor_credentials.dart' as razorCredentials;

// void main() {
//   HttpOverrides.global = MyHttpOverrides();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Razorpay Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final _razorpay = Razorpay();

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//       _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//       _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//     });
//     super.initState();
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     // Do something when payment succeeds
//     print(response);
//     verifySignature(
//       signature: response.signature,
//       paymentId: response.paymentId,
//       orderId: response.orderId,
//     );
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     print(response);
//     // Do something when payment fails
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(response.message ?? ''),
//       ),
//     );
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     print(response);
//     // Do something when an external wallet is selected
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(response.walletName ?? ''),
//       ),
//     );
//   }

// // create order
//   void createOrder() async {
//     String username = razorCredentials.keyId;
//     String password = razorCredentials.keySecret;
//     String basicAuth =
//         'Basic ${base64Encode(utf8.encode('$username:$password'))}';

//     Map<String, dynamic> body = {
//       "amount": 100,
//       "currency": "INR",
//       "receipt": "rcptid_11"
//     };
//     var res = await http.post(
//       Uri.https(
//           "api.razorpay.com", "v1/orders"), //https://api.razorpay.com/v1/orders
//       headers: <String, String>{
//         "Content-Type": "application/json",
//         'authorization': basicAuth,
//       },
//       body: jsonEncode(body),
//     );

//     if (res.statusCode == 200) {
//       openGateway(jsonDecode(res.body)['id']);
//     }
//     print(res.body);
//   }

//   openGateway(String orderId) {
//     var options = {
//       'key': razorCredentials.keyId,
//       'amount': 100, //in the smallest currency sub-unit.
//       'name': 'Acme Corp.',
//       'order_id': orderId, // Generate order_id using Orders API
//       'description': 'Fine T-Shirt',
//       'timeout': 60 * 5, // in seconds // 5 minutes
//       'prefill': {
//         'contact': '9123456789',
//         'email': 'ary@example.com',
//       }
//     };
//     _razorpay.open(options);
//   }

//   verifySignature({
//     String? signature,
//     String? paymentId,
//     String? orderId,
//   }) async {
//     Map<String, dynamic> body = {
//       'razorpay_signature': signature,
//       'razorpay_payment_id': paymentId,
//       'razorpay_order_id': orderId,
//     };

//     var parts = [];
//     body.forEach((key, value) {
//       parts.add('${Uri.encodeQueryComponent(key)}='
//           '${Uri.encodeQueryComponent(value)}');
//     });
//     var formData = parts.join('&');
//     var res = await http.post(
//       Uri.https(
//         "10.0.2.2", // my ip address , localhost
//         "razorpay_signature_verify.php",
//       ),
//       headers: {
//         "Content-Type": "application/x-www-form-urlencoded", // urlencoded
//       },
//       body: formData,
//     );

//     print(res.body);
//     if (res.statusCode == 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(res.body),
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _razorpay.clear(); // Removes all listeners

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Razorpay Demo"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 createOrder();
//               },
//               child: const Text("Pay Rs.100"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }





















// signin page 


// ======================


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerceapp/provider/account.dart';

// import 'package:flutter/material.dart';

// class AccountProvider with ChangeNotifier {
//   final _cloud = FirebaseFirestore.instance;

//   Account? _account;

//   Account? get account {
//     return _account;
//   }

//   Future<void> getUser(String email) async {
//     try {
//       final result = await _cloud
//           .collection("userdata")
//           .where('email', isEqualTo: email)
//           .get();

//       final details = result.docs.first.data();

//       _account = Account(
//         name: details["name"],
//         address: details["address"],
//         email: details["email"],
//         phone: details["phone"],
//       );
//       notifyListeners();
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> checkUser({required String email, required bool isLogin}) async {
//     try {
//       final result = await _cloud
//           .collection("userdata")
//           .where('email', isEqualTo: email)
//           .get();

//           print('email from firebaes : $result');

//       if (result.docs.isNotEmpty) {
//         if (isLogin) {
//           final details = result.docs.first.data();

//           _account = Account(
//             name: details["name"],
//             address: details["address"],
//             email: details["email"],
//             phone: details["phone"],
//           );
//         }
//         notifyListeners();
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

  // Future<void> registeredUser(Account account) async {
  //   try {
  //     final data = {
  //       "name": account.name,
  //       "email": account.email,
  //       "address": account.address,
  //       "phone": account.phone,
  //     };

  //     final details = await _cloud.collection('userdata').add(data);

  //     account.id = details.id;
  //     _account = account;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // List<Account> _accountDetails = [];
  // QuerySnapshot value = await _cloud.collection("userdata").get();

  // for (var element in value.docs) {
  //   var account = Account(
  //     id: element.get("id"),
  //     name: element.get("name"),
  //     address: element.get("address"),
  //     email: element.get("email"),
  //     phone: element.get("phone"),
  //   );

  //   _accountDetails.add(account);
  // }

  // _datas = _accountDetails;
  // print('new details : $_datas');
  // notifyListeners();
// }

  // List<Account> get datas {
  //   return [..._datas];
  // }

















// void _signUp() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isloading = true;
//       });
//       var result =
//           await _auth.createUserWithEmailAndPassword(
//         // name: _nameTextController.text,
//         email: _emailTextController.text,
//         password: _passwordTextController.text,
//         // address: _addressTextController.text,
//         // phone: _phoneTextController.text,
//         // context: context,
//       );
//       User user = result.user;
//       var docid = FirebaseFirestore.instance.collection("userdata").doc();
//       Map<String, dynamic> userdata = {
//         "name": _nameTextController.text,
//         "email": _emailTextController.text,
//         "address": _addressTextController.text,
//         "phone": _phoneTextController.text,
//         "id": docid.id,
//       };
//       FirebaseFirestore.instance
//           .collection("userdata")
//           .add(userdata)
//           .then((value) async {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setString('email', _emailTextController.toString());
//         Navigator.push(
//             (context), MaterialPageRoute(builder: (context) => HomePage()));
//       }).onError((error, stackTrace) {
//         displaySnackBar(text: error.toString(), context: context);
//         print("Error ${error.toString()}");
//       });
//       setState(() {
//         _isloading = false;
//       });
//     }
//   }