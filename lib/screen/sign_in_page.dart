import 'package:ecommerceapp/provider/account_provider.dart';
import 'package:ecommerceapp/screen/home_page.dart';
import 'package:ecommerceapp/screen/reset_password.dart';
import 'package:ecommerceapp/screen/sign_up_page.dart';
import 'package:ecommerceapp/widget/reusables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widget/sign_resuable.dart';

import '../widget/utiles.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isloading = false;
  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
          .then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }).onError((error, stackTrace) {
        displaySnackBar(text: error.toString(), context: context);
        print("Error ${error.toString()}");
      });
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isloading
          ? loader(context)
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 3, 0, 14),
                  Color.fromARGB(255, 2, 32, 57),
                  Color.fromARGB(255, 6, 63, 109),
                  Color.fromARGB(255, 14, 92, 156),
                  Colors.blue
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _emailTextController,
                          obscureText: false,
                          cursorColor: Colors.white,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.mail,
                              color: Colors.white70,
                            ),
                            labelText: 'Enter your email',
                            labelStyle: GoogleFonts.openSans(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w600),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white.withOpacity(0.3),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            // Check if this field is empty
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }

                            // using regular expression
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return "Please enter a valid email address";
                            }

                            // the email is valid
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordTextController,
                          obscureText: true,
                          cursorColor: Colors.white,
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white70,
                            ),
                            labelText: 'Enter your password',
                            labelStyle: GoogleFonts.openSans(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w600),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white.withOpacity(0.3),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val) {
                            if (val!.trim().length < 6) {
                              return 'Password must be atleast 6 characters';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        forgetPassword(context),
                        firebaseUIButton(context, "Sign In", () {
                          _login();
                        }),
                        signUpOption()
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have account?",
            style: GoogleFonts.openSans(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: Text(
            " Sign Up",
            style: GoogleFonts.openSans(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text(
          "Forgot Password?",
          style: GoogleFonts.openSans(
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }
}
