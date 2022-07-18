import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/screen/edit_account_page.dart';
import 'package:ecommerceapp/widget/reusables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  static const routeName = '/account_Details';

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    print("hi hello");
    _getDataFromDatabase();
  }

  final _cloud = FirebaseFirestore.instance;

  String? name = '';
  String? email = '';
  String? address = '';
  String? phone = '';

  Future _getDataFromDatabase() async {
    setState(() {
      _isLoading = true;
    });
    await _cloud
        .collection("userData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!["name"];
          email = snapshot.data()!["email"];
          address = snapshot.data()!["address"];
          phone = snapshot.data()!["phone"];
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromARGB(255, 3, 0, 14),
                  Color.fromARGB(255, 2, 32, 57),
                  Color.fromARGB(255, 6, 63, 109),
                  Color.fromARGB(255, 19, 109, 182),
                  Colors.blue
                ]),
          ),
        ),
        title: Text(
          "My Account",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 19, color: Colors.white),
        ),
      ),
      body: _isLoading
          ? loader(context)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color.fromARGB(255, 15, 119, 205),
                            width: 1.5),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Icon(
                                FontAwesomeIcons.idCard,
                                size: 30,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Text(
                                  ':',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  name!,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Icon(
                                Icons.email,
                                size: 28,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Text(
                                  ':',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  email!,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Icon(
                                Icons.phone,
                                size: 30,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Text(
                                  ':',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  phone!,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Icon(
                                FontAwesomeIcons.houseChimneyUser,
                                size: 30,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Text(
                                  ':',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  address!,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.of(context)
                    //         .pushNamed(EditAccountPage.routeName);
                    //   },
                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     width: 160,
                    //     height: 45,
                    //     decoration: const BoxDecoration(
                    //         gradient: LinearGradient(
                    //             begin: Alignment.topCenter,
                    //             end: Alignment.bottomCenter,
                    //             colors: <Color>[
                    //               Color.fromARGB(255, 9, 50, 85),
                    //               Color.fromARGB(255, 19, 109, 182),
                    //               Colors.blue
                    //             ]),
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(40))),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         const Icon(
                    //           Icons.edit,
                    //           color: Colors.white,
                    //           size: 20,
                    //         ),
                    //         const SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           'Edit',
                    //           style: GoogleFonts.poppins(
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w700,
                    //               color: Colors.white),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
