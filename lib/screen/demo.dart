// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart' as path;
// import 'package:sentry_flutter/sentry_flutter.dart';

// import '../utilities/enum_helper.dart';

// class AppUser {
//   String? id;
//   String name;
//   String mobileNumber;
//   String role;
//   String facebook;
//   String instagram;
//   String twitter;
//   String imageID;
//   String imageURL;

//   AppUser({
//     this.id,
//     required this.name,
//     required this.mobileNumber,
//     required this.role,
//     required this.facebook,
//     required this.instagram,
//     required this.twitter,
//     required this.imageID,
//     required this.imageURL,
//   });
// }

// class AppUserProvider with ChangeNotifier {
//   final _cloud = FirebaseFirestore.instance;
//   final _storage = FirebaseStorage.instance;
//   AppUser? _appUser;
//   List<Map<String, dynamic>> _emails = [];

//   AppUser? get appUser {
//     return _appUser;
//   }

//   List<Map<String, dynamic>> get emails {
//     return _emails;
//   }

//   Future<ProviderResponse> getUser(String mobileNumber) async {
//     try {
//       final result = await _cloud
//           .collection('user')
//           .where('mobileNumber', isEqualTo: mobileNumber)
//           .get();
//       final data = result.docs.first.data();
//       _appUser = AppUser(
//         facebook: data["facebook"],
//         imageID: data["imageID"],
//         imageURL: data["imageURL"],
//         instagram: data["instagram"],
//         role: data["role"],
//         twitter: data["twitter"],
//         id: result.docs.first.id,
//         mobileNumber: data["mobileNumber"],
//         name: data["name"],
//       );
//       notifyListeners();
//       return ProviderResponse.success;
//     } catch (e) {
//       await Sentry.captureException(e);
//       return ProviderResponse.error;
//     }
//   }

//   Future<ProviderResponse> checkUser(
//       {required String mobileNumber, required bool isLogin}) async {
//     try {
//       final result = await _cloud
//           .collection('user')
//           .where('mobileNumber', isEqualTo: mobileNumber)
//           .get();
//       if (result.docs.isNotEmpty) {
//         if (isLogin) {
//           final data = result.docs.first.data();
//           _appUser = AppUser(
//             facebook: data["facebook"],
//             imageID: data["imageID"],
//             imageURL: data["imageURL"],
//             instagram: data["instagram"],
//             role: data["role"],
//             twitter: data["twitter"],
//             id: result.docs.first.id,
//             mobileNumber: data["mobileNumber"],
//             name: data["name"],
//           );
//         }
//         notifyListeners();
//         return ProviderResponse.userExists;
//       } else {
//         return ProviderResponse.userDoesnotExist;
//       }
//     } catch (e) {
//       await Sentry.captureException(e);
//       return ProviderResponse.error;
//     }
//   }

//   Future<ProviderResponse> registerUser(AppUser appUser) async {
//     try {
//       final data = {
//         "name": appUser.name,
//         "facebook": appUser.facebook,
//         "imageID": appUser.imageID,
//         "imageURL": appUser.imageURL,
//         "instagram": appUser.instagram,
//         "mobileNumber": appUser.mobileNumber,
//         "role": appUser.role,
//         "twitter": appUser.twitter,
//       };
//       final responseData = await _cloud.collection('user').add(data);
//       appUser.id = responseData.id;
//       _appUser = appUser;
//       return ProviderResponse.success;
//     } catch (e) {
//       await Sentry.captureException(e);
//       return ProviderResponse.error;
//     }
//   }

//   Future<ProviderResponse> checkMobileNumber(String mobileNumber) async {
//     try {
//       final response = await _cloud
//           .collection('user')
//           .where('mobileNumber', isEqualTo: mobileNumber)
//           .get();
//       if (response.docs.isNotEmpty) {
//         return ProviderResponse.userExists;
//       }
//       return ProviderResponse.userDoesnotExist;
//     } catch (e) {
//       await Sentry.captureException(e);
//       return ProviderResponse.error;
//     }
//   }

//   Future<ProviderResponse> editUser(AppUser appUser) async {
//     try {
//       final data = {
//         "name": appUser.name,
//         "facebook": appUser.facebook,
//         "imageID": appUser.imageID,
//         "imageURL": appUser.imageURL,
//         "instagram": appUser.instagram,
//         "mobileNumber": appUser.mobileNumber,
//         "role": appUser.role,
//         "twitter": appUser.twitter,
//       };
//       await _cloud.collection('user').doc(appUser.id).update(data);
//       _appUser = appUser;
//       notifyListeners();
//       ;
//       return ProviderResponse.success;
//     } catch (e) {
//       await Sentry.captureException(e);
//       return ProviderResponse.error;
//     }
//   }

//   Future<ProviderResponse> changeProfileImage(
//       {required File file,
//       required String userid,
//       required String imageID}) async {
//     try {
//       if (imageID != "") {
//         await _storage.ref().child(imageID).delete();
//       }
//       final imageUpload = await _storage
//           .ref()
//           .child('$userid/profile${path.extension(file.path)}')
//           .putFile(file);
//       final downloadUrl = await imageUpload.ref.getDownloadURL();
//       await _cloud.collection('user').doc(userid).update({
//         "imageID": imageUpload.ref.fullPath,
//         "imageURL": downloadUrl,
//       });
//       _appUser!.imageID = imageUpload.ref.fullPath;
//       _appUser!.imageURL = downloadUrl;
//       notifyListeners();
//       return ProviderResponse.success;
//     } catch (e) {
//       await Sentry.captureException(e);
//       return ProviderResponse.error;
//     }
//   }

//   Future<ProviderResponse> getConfigDetails() async {
//     try {
//       final response = await _cloud
//           .collection('config')
//           .where('flag', isEqualTo: true)
//           .get();
//       if (response.docs.length != 0) {
//         final data = response.docs.first.data();
//         _emails = List<Map<String, dynamic>>.from(data["admin"]);
//         if (data["maintenance"] == true) {
//           return ProviderResponse.underMaintenance;
//         }
//       }
//       notifyListeners();
//       return ProviderResponse.success;
//     } catch (e) {
//       await Sentry.captureException(e);
//       return ProviderResponse.error;
//     }
//   }

//   void clear() {
//     _appUser = null;
//     notifyListeners();
//   }
// }