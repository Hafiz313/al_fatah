// /*
// open(BuildContext context) {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               backgroundColor: Constants.white,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(20.0))),
//               contentPadding: EdgeInsets.only(top: 5.0),
//               content: SingleChildScrollView(child: KchBhi()),
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: TextButton(
//                       child: Text(
//                         'Cancel',
//                         style: TextStyle(color: Constants.red),
//                       ),
//                       onPressed: () {
//                         setState(() {});
//                         Navigator.of(context).pop();
//                       }),
//                 ),
//               ],
//             );
//           },
//         );
//       });
// }
//
// Future<List<SubjectModel>> getSubjectData() async {
//   var url =
//   Uri.parse("https://lyceumgroupofschools.com/api/v1/teacher/subjects");
//   var response = await http.post(
//     url,
//   );
//   final data = json.decode(response.body)["data"];
//   print(json.decode(response.body)["data"].length);
//
//   setState(() {
//     for (int a = 1; a < json.decode(response.body)["data"].length; a++) {
//       subjectDuplicateItems
//           .add(json.decode(response.body)["data"][a]['sub_name']);
//     }
//     subjectItems.addAll(subjectDuplicateItems);
//   });
//
//   print("xxxxxxxxxxxxxx$subjectItems");
//   return SubjectModel.fromJsonList(data);
// }
//
// }
//
//
//
//
//
// class searchInSubject extends StatefulWidget {
//   const searchInSubject({Key? key}) : super(key: key);
//
//   @override
//   _searchInSubjectState createState() => _searchInSubjectState();
// }
//
// class _searchInSubjectState extends State<searchInSubject> {
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
// }*/
