import 'package:ecommerceapp/screen/edit_account_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MY Account",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 19),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Theme.of(context).primaryColor),
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
                            width: MediaQuery.of(context).size.width * 0.05),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            ':',
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            " provider.appUser!.id!",
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
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
                          FontAwesomeIcons.idCardClip,
                          size: 28,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            ':',
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            " provider.appUser!.name",
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
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
                            width: MediaQuery.of(context).size.width * 0.05),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            ':',
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            "provider.appUser!.mobileNumber",
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
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
                          FontAwesomeIcons.user,
                          size: 30,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            ':',
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            " provider.appUser!.role",
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
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
                          FontAwesomeIcons.facebookSquare,
                          size: 30,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            ':',
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            " provider.appUser!.facebook",
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
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
                          FontAwesomeIcons.instagram,
                          size: 30,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            ':',
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            " provider.appUser!.instagram",
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
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
                          FontAwesomeIcons.twitterSquare,
                          size: 30,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            ':',
                            style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            " provider.appUser!.twitter",
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
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
              SizedBox(
                width: 130,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      EditAccountPage.routeName,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Edit',
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
