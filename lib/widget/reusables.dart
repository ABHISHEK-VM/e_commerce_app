import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void displaySnackBar({required String text, BuildContext? context}) {
  ScaffoldMessenger.of(context!).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Colors.white,
      margin: EdgeInsets.all(17),
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: GoogleFonts.poppins(
            color: Colors.black, fontWeight: FontWeight.w600),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    ),
  );
}
