// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import 'package:artistoclub/pages/user_details_editing_page.dart';
// import 'package:artistoclub/utilities/reusable.dart';
// import '../provider/app_user_provider.dart';

// class AccountDetails extends StatefulWidget {
//   static const routeName = '/accountDetails';
//   const AccountDetails({Key? key}) : super(key: key);
//   @override
//   _AccountDetailsState createState() => _AccountDetailsState();
// }

// class _AccountDetailsState extends State<AccountDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appbar(),
//       body: SingleChildScrollView(
//         child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Consumer<AppUserProvider>(
//               builder: (ctx, provider, _) => Column(
//                 children: [
//                   const Text(
//                     'My Account',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   provider.appUser!.imageURL == ""
//                       ? Container(
//                           height: 130,
//                           width: 130,
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                                 width: 2,
//                                 color: Theme.of(context).primaryColor),
//                             shape: BoxShape.circle,
//                             image: const DecorationImage(
//                                 image: AssetImage('assets/user.png'),
//                                 fit: BoxFit.fitHeight),
//                           ),
//                         )
//                       : CachedNetworkImage(
//                           imageBuilder: (context, imageProvider) => Container(
//                             height: 130,
//                             width: 130,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   width: 2,
//                                   color: Theme.of(context).primaryColor),
//                               shape: BoxShape.circle,
//                               image: DecorationImage(
//                                   image: imageProvider, fit: BoxFit.cover),
//                             ),
//                           ),
//                           imageUrl: provider.appUser!.imageURL,
//                           progressIndicatorBuilder:
//                               (context, url, downloadProgress) =>
//                                   CircularProgressIndicator(
//                                       value: downloadProgress.progress),
//                           errorWidget: (context, url, error) =>
//                               const Icon(Icons.error),
//                         ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(15),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Theme.of(context).primaryColor),
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             const Icon(
//                               FontAwesomeIcons.idCard,
//                               size: 30,
//                             ),
//                             SizedBox(
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.05),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 20.0),
//                               child: Text(
//                                 ':',
//                                 style: GoogleFonts.openSans(
//                                     fontWeight: FontWeight.w300),
//                               ),
//                             ),
//                             Flexible(
//                               fit: FlexFit.loose,
//                               child: Text(
//                                 provider.appUser!.id!,
//                                 softWrap: true,
//                                 overflow: TextOverflow.visible,
//                                 style: GoogleFonts.roboto(
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             const Icon(
//                               FontAwesomeIcons.idCardAlt,
//                               size: 28,
//                             ),
//                             SizedBox(
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.05),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 20.0),
//                               child: Text(
//                                 ':',
//                                 style: GoogleFonts.openSans(
//                                     fontWeight: FontWeight.w300),
//                               ),
//                             ),
//                             Flexible(
//                               fit: FlexFit.loose,
//                               child: Text(
//                                 provider.appUser!.name,
//                                 softWrap: true,
//                                 overflow: TextOverflow.visible,
//                                 style: GoogleFonts.roboto(
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             const Icon(
//                               Icons.phone,
//                               size: 30,
//                             ),
//                             SizedBox(
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.05),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 20.0),
//                               child: Text(
//                                 ':',
//                                 style: GoogleFonts.openSans(
//                                     fontWeight: FontWeight.w300),
//                               ),
//                             ),
//                             Flexible(
//                               fit: FlexFit.loose,
//                               child: Text(
//                                 provider.appUser!.mobileNumber,
//                                 softWrap: true,
//                                 overflow: TextOverflow.visible,
//                                 style: GoogleFonts.roboto(
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             const Icon(
//                               FontAwesomeIcons.user,
//                               size: 30,
//                             ),
//                             SizedBox(
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.05),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 20.0),
//                               child: Text(
//                                 ':',
//                                 style: GoogleFonts.openSans(
//                                     fontWeight: FontWeight.w300),
//                               ),
//                             ),
//                             Flexible(
//                               fit: FlexFit.loose,
//                               child: Text(
//                                 provider.appUser!.role,
//                                 softWrap: true,
//                                 overflow: TextOverflow.visible,
//                                 style: GoogleFonts.roboto(
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             const Icon(
//                               FontAwesomeIcons.facebookSquare,
//                               size: 30,
//                             ),
//                             SizedBox(
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.05),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 20.0),
//                               child: Text(
//                                 ':',
//                                 style: GoogleFonts.openSans(
//                                     fontWeight: FontWeight.w300),
//                               ),
//                             ),
//                             Flexible(
//                               fit: FlexFit.loose,
//                               child: Text(
//                                 provider.appUser!.facebook,
//                                 softWrap: true,
//                                 overflow: TextOverflow.visible,
//                                 style: GoogleFonts.roboto(
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             const Icon(
//                               FontAwesomeIcons.instagram,
//                               size: 30,
//                             ),
//                             SizedBox(
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.05),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 20.0),
//                               child: Text(
//                                 ':',
//                                 style: GoogleFonts.openSans(
//                                     fontWeight: FontWeight.w300),
//                               ),
//                             ),
//                             Flexible(
//                               fit: FlexFit.loose,
//                               child: Text(
//                                 provider.appUser!.instagram,
//                                 softWrap: true,
//                                 overflow: TextOverflow.visible,
//                                 style: GoogleFonts.roboto(
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             const Icon(
//                               FontAwesomeIcons.twitterSquare,
//                               size: 30,
//                             ),
//                             SizedBox(
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.05),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 20.0),
//                               child: Text(
//                                 ':',
//                                 style: GoogleFonts.openSans(
//                                     fontWeight: FontWeight.w300),
//                               ),
//                             ),
//                             Flexible(
//                               fit: FlexFit.loose,
//                               child: Text(
//                                 provider.appUser!.twitter,
//                                 softWrap: true,
//                                 overflow: TextOverflow.visible,
//                                 style: GoogleFonts.roboto(
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   SizedBox(
//                     width: 130,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         elevation: 6,
//                         primary: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).pushNamed(
//                           UserDetailsEditingPage.routeName,
//                         );
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(
//                             Icons.edit,
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             'Edit',
//                             style: GoogleFonts.roboto(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white),
//                           ), 
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
// }