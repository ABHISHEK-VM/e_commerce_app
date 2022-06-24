// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:artistoclub/pages/crew_profile_page.dart';
// import 'package:artistoclub/provider/casting_call_provider.dart';

// import '../utilities/enum_helper.dart';
// import '../utilities/reusable.dart';
// import '../utilities/sql_helper.dart';

// class RequirementProjectDetails extends StatefulWidget {
//   static const routeName = '/RequirementProjectDetails';
//   const RequirementProjectDetails({Key? key}) : super(key: key);

//   @override
//   _RequirementProjectDetailsState createState() =>
//       _RequirementProjectDetailsState();
// }

// class _RequirementProjectDetailsState extends State<RequirementProjectDetails>
//     with SingleTickerProviderStateMixin {
//   late TabController tabcontroller;
//   late CastingCall newObj;
//   late bool isBookmarkable;
//   late bool showApplyButton;

//   String timeAgo(DateTime d) {
//     Duration diff = DateTime.now().difference(d);
//     if (diff.inDays > 365)
//       return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
//     if (diff.inDays > 30)
//       return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
//     if (diff.inDays > 7)
//       return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
//     if (diff.inDays > 0)
//       return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
//     if (diff.inHours > 0)
//       return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
//     if (diff.inMinutes > 0)
//       return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
//     return "just now";
//   }

//   @override
//   void initState() {
//     tabcontroller = TabController(length: 2, vsync: this);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final data =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//     newObj = data["castingCall"] as CastingCall;
//     List<String> requirements = [];
//     for (var requirement in newObj.requirements) {
//       requirements.add(requirement.role);
//     }
//     isBookmarkable = data["isBookmarkable"] as bool;
//     showApplyButton = data["showApplyButton"] as bool;
//     return Scaffold(
//       appBar: appbar(),
//       body: Column(
//         children: [
//           TabBar(
//             tabs: const [
//               Tab(
//                 text: 'Requirement',
//               ),
//               Tab(text: 'Project Details'),
//             ],
//             controller: tabcontroller,
//             labelColor: Color(0xFF3c3c7a),
//             indicatorSize: TabBarIndicatorSize.tab,
//           ),
//           Expanded(
//               child: TabBarView(
//             children: [
//               SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(11.0),
//                   child: Column(
//                     children: [
//                       Card(
//                         margin: const EdgeInsets.all(8),
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         clipBehavior: Clip.antiAlias,
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(15, 8, 17, 8),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width:
//                                         MediaQuery.of(context).size.width * .45,
//                                     child: Text(
//                                       newObj.projectName,
//                                       style: GoogleFonts.roboto(
//                                         color: Colors.black,
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width:
//                                         MediaQuery.of(context).size.width * .37,
//                                     child: Text(
//                                       timeAgo(
//                                         newObj.callStatus == CallStatus.approved
//                                             ? DateTime.parse(
//                                                 newObj.approvedTime)
//                                             : newObj.callStatus ==
//                                                     CallStatus.closed
//                                                 ? DateTime.parse(
//                                                     newObj.closedTime)
//                                                 : DateTime.parse(
//                                                     newObj.postedTime),
//                                       ),
//                                       textAlign: TextAlign.end,
//                                       style: GoogleFonts.roboto(
//                                         color: Colors.grey,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             CachedNetworkImage(
//                               fit: BoxFit.cover,
//                               imageBuilder: (context, imageProvider) =>
//                                   Container(
//                                 height:
//                                     MediaQuery.of(context).size.height * .28,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.rectangle,
//                                   image: DecorationImage(
//                                       image: imageProvider, fit: BoxFit.cover),
//                                 ),
//                               ),
//                               imageUrl: newObj.posterURL,
//                               progressIndicatorBuilder:
//                                   (context, url, downloadProgress) =>
//                                       CircularProgressIndicator(
//                                           value: downloadProgress.progress),
//                               errorWidget: (context, url, error) =>
//                                   const Icon(Icons.error),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(15, 8, 17, 8),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceAround,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 .67,
//                                         child: Text(
//                                           requirements
//                                               .toSet()
//                                               .toList()
//                                               .join(", "),
//                                           style: GoogleFonts.roboto(
//                                             color: Colors.black,
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 .67,
//                                         child: Text(
//                                           '${newObj.language} ${newObj.projectType}',
//                                           style: GoogleFonts.roboto(
//                                             color: Colors.grey,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   isBookmarkable
//                                       ? IconButton(
//                                           onPressed: () async {
//                                             if (newObj.isBookmarked!) {
//                                               final response = await SQLHelper
//                                                   .removeBookmark(
//                                                 callId: newObj.id!,
//                                                 context: context,
//                                               );
//                                               if (response ==
//                                                   ProviderResponse.success) {
//                                                 displaySnackBar(
//                                                   text:
//                                                       "Casting Call un-bookmarked successfully!",
//                                                   context: context,
//                                                 );
//                                                 setState(() {
//                                                   newObj.isBookmarked = false;
//                                                 });
//                                               } else {
//                                                 displaySnackBar(
//                                                   text:
//                                                       "An unexpected error had occured while un-bookmarking the casting call! Please try again!",
//                                                   context: context,
//                                                 );
//                                               }
//                                             } else {
//                                               final response =
//                                                   await SQLHelper.addBookmark(
//                                                       data: {
//                                                     "callId": newObj.id!,
//                                                     "callName":
//                                                         newObj.projectName,
//                                                   },
//                                                       context: context);
//                                               if (response ==
//                                                   ProviderResponse.success) {
//                                                 displaySnackBar(
//                                                   text:
//                                                       "Casting Call bookmarked successfully!",
//                                                   context: context,
//                                                 );
//                                                 setState(() {
//                                                   newObj.isBookmarked = true;
//                                                 });
//                                               } else {
//                                                 displaySnackBar(
//                                                   text:
//                                                       "An unexpected error had occured while bookmarking the casting call! Please try again!",
//                                                   context: context,
//                                                 );
//                                               }
//                                             }
//                                           },
//                                           icon: Icon(
//                                             newObj.isBookmarked!
//                                                 ? Icons.bookmark
//                                                 : Icons.bookmark_border,
//                                             size: 30,
//                                             color: newObj.isBookmarked!
//                                                 ? Theme.of(context).primaryColor
//                                                 : Colors.black,
//                                           ),
//                                         )
//                                       : Container(),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Card(
//                         margin: const EdgeInsets.all(8),
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         clipBehavior: Clip.antiAlias,
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                             left: 5.5,
//                             right: 3,
//                             top: 18,
//                             bottom: 18,
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Other Details  :  ',
//                                 style: GoogleFonts.roboto(
//                                   color: Colors.black,
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width * .50,
//                                 child: Text(
//                                   newObj.otherDetails == ""
//                                       ? "None"
//                                       : newObj.otherDetails,
//                                   style: GoogleFonts.roboto(
//                                     color: Colors.black,
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       SizedBox(
//                         height: 150,
//                         child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: newObj.crewDetails.length,
//                             itemBuilder: (context, itemCount) {
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16.0),
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.of(context).pushNamed(
//                                         CrewProfilePage.routeName,
//                                         arguments:
//                                             newObj.crewDetails[itemCount]);
//                                   },
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       SizedBox(
//                                         width: 97,
//                                         child: Text(
//                                           newObj.crewDetails[itemCount].role,
//                                           style: GoogleFonts.roboto(
//                                             color: Colors.grey,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.w400,
//                                           ),
//                                           overflow: TextOverflow.ellipsis,
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                       CachedNetworkImage(
//                                         imageBuilder:
//                                             (context, imageProvider) =>
//                                                 Container(
//                                           height: 80,
//                                           width: 80,
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             image: DecorationImage(
//                                                 image: imageProvider,
//                                                 fit: BoxFit.cover),
//                                           ),
//                                         ),
//                                         imageUrl: newObj
//                                             .crewDetails[itemCount].imageURL,
//                                         progressIndicatorBuilder: (context, url,
//                                                 downloadProgress) =>
//                                             CircularProgressIndicator(
//                                                 value:
//                                                     downloadProgress.progress),
//                                         errorWidget: (context, url, error) =>
//                                             const Icon(Icons.error),
//                                       ),
//                                       SizedBox(
//                                         width: 97,
//                                         child: Text(
//                                           newObj.crewDetails[itemCount].name,
//                                           style: GoogleFonts.roboto(
//                                             color: Colors.black,
//                                             fontSize: 13,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                           textAlign: TextAlign.center,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//             controller: tabcontroller,
//           ))
//         ],
//       ),
//     );
//   }
// }
