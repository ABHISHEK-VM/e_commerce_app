//import 'package:ecommerceapp/provider/inventory.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'dart:async';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
//import 'package:provider/provider.dart';

import '../widget/reusables.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  static const routeName = '/inventory_page';

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _price = TextEditingController();

  File? _selectedFile;

  final _cloud = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  bool _isLoading = false;

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      print("entered into save dTA");
      if (_selectedFile == null) {
        displaySnackBar(text: 'Please upload an image', context: context);
      } else {
        if (_title != null && _description != null && _price != null) {
          UploadTask uploadTask = FirebaseStorage.instance
              .ref()
              .child('productImage')
              .child(const Uuid().v1())
              .putFile(_selectedFile!);

          TaskSnapshot taskSnapshot = await uploadTask;
          String downloadurl = await taskSnapshot.ref.getDownloadURL();
          var docid = FirebaseFirestore.instance.collection("inventory").doc();
          Map<String, dynamic> inventory = {
            "title": _title.text,
            "description": _description.text,
            "imageurl": downloadurl,
            "price": double.parse(_price.text),
            "id": docid.id,
          };
          FirebaseFirestore.instance.collection("inventory").add(inventory);
        }
      }
    }
  }

  void _selectImageSource() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: SizedBox(
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "From where do you want to take the photo?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _pickImage(ImageSource.camera);
                            },
                            child: const Text(
                              "Camera",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _pickImage(ImageSource.gallery);
                            },
                            child: const Text(
                              "Gallery",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          );
        });
  }

  Future<void> _pickImage(ImageSource source) async {
    setState(() {
      _isLoading = true;
    });
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      File? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4),
        compressQuality: 50,
        maxHeight: 700,
        maxWidth: 700,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: const AndroidUiSettings(
          toolbarColor: Color(0xFF3c3c7a),
          toolbarTitle: "Crop",
          statusBarColor: Color(0xFF3c3c7a),
        ),
      );
      setState(() {
        _selectedFile = croppedFile!;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      displaySnackBar(
          text: 'An error occured while selecting poster, please try again!',
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    //  final inventory = Provider.of<InventoryProvider>(context);
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
          "Inventory",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 19, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12.0),
                  onTap: _selectImageSource,
                  child: _selectedFile != null
                      ? Container(
                          margin: const EdgeInsets.all(30),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: const Color(0xff7c94b6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.file(
                            _selectedFile!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : DottedBorder(
                          color: Colors.grey,
                          radius: const Radius.circular(12.0),
                          borderType: BorderType.RRect,
                          padding: const EdgeInsets.only(
                              left: 80, right: 80, top: 40, bottom: 40),
                          child: Column(
                            children: const [
                              Icon(Icons.cloud_upload_outlined,
                                  size: 60, color: Colors.grey),
                              Text(
                                'Pick an Image',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      TextFormField(
                        controller: _title,
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
                        'Description',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      TextFormField(
                        controller: _description,
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
                        'Price',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      TextFormField(
                        controller: _price,
                        keyboardType: TextInputType.number,
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
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
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
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Color.fromARGB(255, 9, 50, 85),
                              Color.fromARGB(255, 19, 109, 182),
                              Colors.blue
                            ]),

                        // border: Border.all(
                        //     // color: Colors.amberAccent,
                        //     ),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 56),
                    child: Text(
                      'Save',
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
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
