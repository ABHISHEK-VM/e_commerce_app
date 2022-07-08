import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/provider/sign_up_provider.dart';
import 'package:ecommerceapp/screen/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widget/sign_resuable.dart';

import '../widget/utiles.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();
  void signUpUser() async {
    FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
      name: _userNameTextController.text,
      email: _emailTextController.text,
      password: _passwordTextController.text,
      address: _addressTextController.text,
      phone: _phoneTextController.text,
      context: context,
    );
    var docid = FirebaseFirestore.instance.collection("userdata").doc();
    Map<String, dynamic> userdata = {
      "name": _userNameTextController.text,
      "email": _emailTextController.text,
      "address": _addressTextController.text,
      "phone": _phoneTextController.text,
      "id": docid.id,
    };
    FirebaseFirestore.instance.collection("userdata").add(userdata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Address", Icons.person_outline, false,
                    _addressTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Phone numbr", Icons.person_outline, false,
                    _phoneTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () {
                  signUpUser();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                })
              ],
            ),
          ))),
    );
  }
}
