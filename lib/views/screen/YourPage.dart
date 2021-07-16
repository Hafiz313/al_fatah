// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
//
//
// List<dynamic> subjectDuplicateItems = [];
// List<dynamic> gradeDuplicateItems = [];
// var subjectItems = [];
// var gradeItems = [];
//
// class Diary extends StatefulWidget {
//
//
//   @override
//   _DiaryState createState() => _DiaryState();
// }
//
// class _DiaryState extends State<Diary> {
//   final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//
//   DateTime selectedDate = DateTime.now();
//   DateTime date = DateTime.now();
//   static final TextEditingController _workController = TextEditingController();
//
//   bool toFocus = false,
//       gradeFocus = false,
//       gradeError = false,
//       subjectFocus = false,
//       subjectError = false,
//       dateError = false;
//   String grade = '5th', subject = 'English';
//   int? leaveTypeId;
//
//   @override
//   void initState() {
//     getSubjectData();
//     // getGradeData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(
//               Icons.chevron_left_outlined,
//               size: 30,
//             )),
//         elevation: 0.0,
//         backgroundColor: Constants.black_light,
//       ),
//       backgroundColor: Constants.black_light,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Form(
//                 key: _formKey,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Add Diary",
//                             style: TextStyle(
//                                 fontSize: 22, fontWeight: FontWeight.bold),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         'Date',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       GestureDetector(
//                           onTap: () {
//                             final kch = _show(false);
//                             print(kch);
//                           },
//                           child: Container(
//                             height: 45,
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(
//                                 border: toFocus
//                                     ? Border.all(color: Constants.bg_primary)
//                                     : dateError
//                                     ? Border.all(color: Colors.red)
//                                     : Border.all(color: Colors.grey),
//                                 borderRadius: BorderRadius.circular(10)),
//                             margin: EdgeInsets.symmetric(vertical: 10),
//                             child: Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: [
//                                   Text(date.toString().substring(0, 10)),
//                                   Spacer(),
//                                   Icon(Icons.calendar_today_outlined)
//                                 ],
//                               ),
//                             ),
//                           )),
//                       Text(
//                         "Grade",
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             gradeError = false;
//                             gradeFocus = !gradeFocus;
//                           });
//                         },
//                         child: Container(
//                           height: 45,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               border: gradeFocus
//                                   ? Border.all(color: Constants.bg_primary)
//                                   : gradeError
//                                   ? Border.all(color: Colors.red)
//                                   : Border.all(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(10)),
//                           margin: EdgeInsets.symmetric(vertical: 10),
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Text(grade),
//                                 Spacer(),
//                                 Icon(gradeFocus
//                                     ? Icons.keyboard_arrow_up_outlined
//                                     : Icons.keyboard_arrow_down_outlined)
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Text(
//                         "Subject",
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           open(context);
//                           setState(() {
//                             subjectError = false;
//                             subjectFocus = !gradeFocus;
//                           });
//                         },
//                         child: Container(
//                           height: 45,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               border: subjectFocus
//                                   ? Border.all(color: Constants.bg_primary)
//                                   : subjectError
//                                   ? Border.all(color: Colors.red)
//                                   : Border.all(color: Colors.grey),
//                               borderRadius: BorderRadius.circular(10)),
//                           margin: EdgeInsets.symmetric(vertical: 10),
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Text(subject),
//                                 Spacer(),
//                                 Icon(subjectFocus
//                                     ? Icons.keyboard_arrow_up_outlined
//                                     : Icons.keyboard_arrow_down_outlined)
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         'Add Work',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       TextFormField(
//                         keyboardType: TextInputType.multiline,
//                         minLines: 8,
//                         maxLines: 8,
//                         controller: _workController,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Query field is required';
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 10),
//                           focusedBorder: Constants.outlineInputBorder(
//                               Constants.bg_primary),
//                           enabledBorder:
//                           Constants.outlineInputBorder(Colors.grey),
//                           border: Constants.outlineInputBorder(
//                               Constants.bg_primary),
//                           errorBorder: Constants.outlineInputBorder(Colors.red),
//                           focusedErrorBorder:
//                           Constants.outlineInputBorder(Colors.red),
//                           errorMaxLines: 1,
//                           hintText: "Add work Details",
//                           hintStyle: TextStyle(color: Colors.black54),
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height / 22,
//                       ),
//                       Center(
//                         child: Container(
//                           width: MediaQuery.of(context).size.width / 1.1,
//                           height: 45,
//                           child: TextButton(
//                               style: TextButton.styleFrom(
//                                   backgroundColor: Constants.bg_primary,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(15))),
//                               onPressed: () {},
//                               child: Text(
//                                 'Submit',
//                                 style: TextStyle(color: Constants.white),
//                               )),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<dynamic> _show(bool from) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate, // Refer step 1
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2030),
//       helpText: "Select Date",
//       cancelText: "Cancel",
//     );
//     setState(() {
//       date = picked!;
//       // selected = true;
//     });
//   }
//
//   open(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return StatefulBuilder(
//             builder: (context, setState) {
//               return AlertDialog(
//                 backgroundColor: Constants.white,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20.0))),
//                 contentPadding: EdgeInsets.only(top: 5.0),
//                 content: SingleChildScrollView(child: SearchInSubject()),
//                 actions: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8.0),
//                     child: TextButton(
//                         child: Text(
//                           'Cancel',
//                           style: TextStyle(color: Constants.red),
//                         ),
//                         onPressed: () {
//                           setState(() {});
//                           Navigator.of(context).pop();
//                         }),
//                   ),
//                 ],
//               );
//             },
//           );
//         });
//   }
//
//   Future<List<SubjectModel>> getSubjectData() async {
//     var url =
//     Uri.parse("https://lyceumgroupofschools.com/api/v1/teacher/subjects");
//     var response = await http.post(
//       url,
//     );
//     final data = json.decode(response.body)["data"];
//     print(json.decode(response.body)["data"].length);
//
//     setState(() {
//       for (int a = 1; a < json.decode(response.body)["data"].length; a++) {
//         subjectDuplicateItems
//             .add(json.decode(response.body)["data"][a]['sub_name']);
//       }
//       subjectItems.addAll(subjectDuplicateItems);
//     });
//
//     print("xxxxxxxxxxxxxx$subjectItems");
//     return SubjectModel.fromJsonList(data);
//   }
//
//   Future<List<GradeModel>> getGradeData() async {
//     var url =
//         Uri.parse("https://lyceumgroupofschools.com/api/v1/teacher/grade");
//     var response = await http.post(
//       url,
//     );
//     final data = json.decode(response.body)["data"];
//
//     setState(() {
//       for (int a = 1; a < json.decode(response.body)["data"].length; a++) {
//         gradeDuplicateItems
//             .add(json.decode(response.body)["data"][a]['sub_name']);
//       }
//       gradeItems.addAll(gradeDuplicateItems);
//     });
//
//     print("ssssssss$gradeItems");
//     return gradeModel.fromJsonList(data);
//   }
//
//
// }
//
// class SearchInSubject extends StatefulWidget {
//   const SearchInSubject({Key? key}) : super(key: key);
//
//   @override
//   _SearchInSubjectState createState() => _SearchInSubjectState();
// }
//
// class _SearchInSubjectState extends State<SearchInSubject> {
//   static final TextEditingController _subjectController =
//   TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.maxFinite,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: (value) {
//                 filterSearchResults(value.toLowerCase());
//               },
//               controller: _subjectController,
//               decoration: InputDecoration(
//                   labelText: "Search",
//                   hintText: "Search",
//                   prefixIcon: Icon(Icons.search),
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(25.0)))),
//             ),
//           ),
//           ConstrainedBox(
//             constraints: BoxConstraints(
//               maxHeight: MediaQuery.of(context).size.height * 0.4,
//             ),
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: subjectItems.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     print(subjectItems[index]);
//                     print(index);
//                     setState(() {});
//                     FocusScope.of(context).requestFocus(FocusNode());
//                   },
//                   child: ListTile(
//                     title: Text('${subjectItems[index]}'),
//                   ),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   void filterSearchResults(String query) {
//     List<dynamic> dummySearchList = [];
//     print('$query');
//     dummySearchList.addAll(subjectDuplicateItems);
//     if (query.isNotEmpty) {
//       List<dynamic> dummyListData = [];
//       dummySearchList.forEach((item) {
//         if (item.toLowerCase().contains(query)) {
//           dummyListData.add(item);
//         }
//       });
//       setState(() {
//         subjectItems.clear();
//         subjectItems.addAll(dummyListData);
//       });
//       return;
//     } else {
//       setState(() {
//         subjectItems.clear();
//         subjectItems.addAll(subjectDuplicateItems);
//       });
//     }
//   }
// }
