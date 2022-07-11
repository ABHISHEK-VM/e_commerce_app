import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({Key? key}) : super(key: key);

  static const routeName = '/edit_account_page';

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();

  final _phoneNo = TextEditingController();

  final _address = TextEditingController();

  final _cloud = FirebaseFirestore.instance;

  final _storage = FirebaseStorage.instance;
  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      print("entered into save dTA");

      if (_address != null && _name != null && _phoneNo != null) {
        var docid = FirebaseFirestore.instance.collection("account").doc();
        Map<String, dynamic> account = {
          "name": _name.text,
          "address": _address.text,
          "phoneno": _phoneNo.text,
          "id": docid.id,
        };
        FirebaseFirestore.instance.collection("account").add(account);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Account",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 19),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  'Name',
                  style: GoogleFonts.roboto(fontSize: 15, color: Colors.grey),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                TextFormField(
                  controller: _name,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  validator: (val) {
                    if (val!.trim().length < 2) {
                      return 'Enter a valid Title';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Text(
                  'Address',
                  style: GoogleFonts.roboto(fontSize: 15, color: Colors.grey),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                TextFormField(
                  controller: _address,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  validator: (val) {
                    if (val!.trim().length < 2) {
                      return 'Tell something abt the product';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Text(
                  'Phone Number',
                  style: GoogleFonts.roboto(fontSize: 15, color: Colors.grey),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                TextFormField(
                  controller: _phoneNo,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  validator: (val) {
                    if (val!.trim().length < 2) {
                      return 'Enter a valid Title';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                InkWell(
                  onTap: () {
                    _saveData();
                    // _title.clear();
                    // _description.clear();

                    // _price.clear();
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(
                        //     // color: Colors.amberAccent,
                        //     ),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Text(
                      'Save',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
