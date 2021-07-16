import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_app/core/datamodels/InventoryResultModel.dart';
import 'package:inventory_app/utils/app_color.dart';
import 'package:inventory_app/utils/app_sizes.dart';
import 'package:inventory_app/views/widgets/MyTextFormField.dart';

import '../base_view.dart';
import 'item_result_screen.dart';

class SearchListExample extends StatefulWidget {
  final  List<InventoryResultModel> inventoryResultsList;

  const SearchListExample({Key key, this.inventoryResultsList}) : super(key: key);
  @override
  _SearchListExampleState createState() => new _SearchListExampleState();
}

class _SearchListExampleState extends State<SearchListExample> {
  Widget appBarTitle = new Text(
    "Search Example",
    style: new TextStyle(color: Colors.white),
  );
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> _list;
  bool _isSearching;
  String _searchText = "";
  List searchresult = new List();

  _SearchListExampleState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    values();
  }

  void values() {
    _list = List();
    _list=widget.inventoryResultsList;
    // _list.add("Indian rupee");
    // _list.add("United States dollar");
    // _list.add("Australian dollar");
    // _list.add("Euro");
    // _list.add("British pound");
    // _list.add("Yemeni rial");
    // _list.add("Japanese yen");
    // _list.add("Hong Kong dollar");
  }
  OutlineInputBorder _outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1.5, color: color?? kPrimaryTextColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: AppSizes.appVerticalLg * 2,
            width: AppSizes.appHorizontalLg * 3,
            child: Image(
              image: AssetImage("images/logo.png"),
            ),
          ),

          Container(
            margin: EdgeInsets.only(bottom: 20,left: 20,),
            child:
            TextField(
              controller: _controller,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: kPrimaryTextColor,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                suffixIcon: icon,
                focusedBorder: _outlineInputBorder(Colors.blue),
                enabledBorder: _outlineInputBorder(kAppPrimaryColor),
                border: _outlineInputBorder(kAppPrimaryColor),
                errorBorder: _outlineInputBorder(kRedColor),
                focusedErrorBorder: _outlineInputBorder(kRedColor),
                hintText: "Searching ...",
                errorMaxLines: 1,
                hintStyle: TextStyle(color: kPrimaryTextColor),
              ),
              onChanged: searchOperation,
            ),

            // IconButton(
            //   icon: icon,
            //   onPressed: () {
            //     setState(() {
            //       if (this.icon.icon == Icons.search) {
            //         this.icon = new Icon(
            //           Icons.close,
            //           color: Colors.white,
            //         );
            //         this.appBarTitle = new TextField(
            //           controller: _controller,
            //           style: new TextStyle(
            //             color: Colors.white,
            //           ),
            //           decoration: new InputDecoration(
            //               prefixIcon: new Icon(Icons.search, color: Colors.white),
            //               hintText: "Search...",
            //               hintStyle: new TextStyle(color: Colors.white)),
            //           onChanged: searchOperation,
            //         );
            //         _handleSearchStart();
            //       } else {
            //         _handleSearchEnd();
            //       }
            //     });
            //   },
            // ),



          ),
          // MyTextFormField(
          //   hintText: "Enter item name",
          //   validator: (value) => value.isEmpty ? "Empty"
          //       : null,
          //   isPassword: false,
          //   isPhone: false,
          //   isEmail: true,
          //   autoFocus: false,
          //     controller: _controller,
          // ),
          _list.length>0? Flexible(
              child: searchresult.length != 0 || _controller.text.isNotEmpty
                  ?  ListView.builder(
                shrinkWrap: true,
                itemCount: searchresult.length,
                itemBuilder: (BuildContext context, int index) {
                  String listData = searchresult[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ItemResultScreen(
                                inventoryResultModel: widget.inventoryResultsList[index],
                              )));
                    },
                    child: new ListTile(
                      title: new Text(listData.toString()),
                    ),
                  );
                },
              )
                  : new ListView.builder(
                shrinkWrap: true,
                itemCount: _list.length,
                itemBuilder: (BuildContext context, int index) {
                  String listData = _list[index] .name;
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ItemResultScreen(
                                inventoryResultModel: widget.inventoryResultsList[index],
                              )));
                    },
                    child: new ListTile(
                      title: new Text(listData.toString()),
                    ),
                  );
                },
              )):Flexible(child: Container(child: Text("No Data"),))
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
    //    TextField(
    // controller: _controller,
    //   style: new TextStyle(
    //     color: Colors.white,
    //   ),
    //   decoration: new InputDecoration(
    //       prefixIcon: new Icon(Icons.search, color: Colors.white),
    //       hintText: "Search...",
    //       hintStyle: new TextStyle(color: Colors.white)),
    //   onChanged: searchOperation,
    // )

      IconButton(
        icon: icon,
        onPressed: () {
          setState(() {
            if (this.icon.icon == Icons.search) {
              this.icon = new Icon(
                Icons.close,
                color: Colors.white,
              );
              this.appBarTitle = new TextField(
                controller: _controller,
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.white),
                    hintText: "Search...",
                    hintStyle: new TextStyle(color: Colors.white)),
                onChanged: searchOperation,
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]

    );
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Search Sample",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i].name;
        if (data.toLowerCase().contains(searchText.toLowerCase()) || data.toLowerCase().contains(searchText.toUpperCase())) {
          searchresult.add(data);
        }
      }
    }
  }
}


// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => new _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   TextEditingController controller = new TextEditingController();
//   List<UserDetails> _searchResult = [];
//
//   List<UserDetails> _userDetails = [];
//
//  // final String url = 'https://jsonplaceholder.typicode.com/users';
//
//   var url =Uri.parse("https://jsonplaceholder.typicode.com/users");
//   // Get json result and convert it to model. Then add
//   Future<Null> getUserDetails() async {
//     final response = await http.get(url);
//     final responseJson = json.decode(response.body);
//
//     setState(() {
//       for (Map user in responseJson) {
//         _userDetails.add(UserDetails.fromJson(user));
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     getUserDetails();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('Home'),
//         elevation: 0.0,
//       ),
//       body: new Column(
//         children: <Widget>[
//           new Container(
//             color: Theme.of(context).primaryColor,
//             child: new Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: new Card(
//                 child: new ListTile(
//                   leading: new Icon(Icons.search),
//                   title: new TextField(
//                     controller: controller,
//                     decoration: new InputDecoration(
//                         hintText: 'Search', border: InputBorder.none),
//                     onChanged: onSearchTextChanged,
//                   ),
//                   trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
//                     controller.clear();
//                     onSearchTextChanged('');
//                   },),
//                 ),
//               ),
//             ),
//           ),
//           new Expanded(
//             child: _searchResult.length != 0 || controller.text.isNotEmpty
//                 ? new ListView.builder(
//               itemCount: _searchResult.length,
//               itemBuilder: (context, i) {
//                 return new Card(
//                   child: new ListTile(
//                     title: new Text(_searchResult[i].firstName ),
//                     //title: new Text(_searchResult[i].firstName + ' ' + _searchResult[i].lastName),
//                   ),
//                   margin: const EdgeInsets.all(0.0),
//                 );
//               },
//             )
//                 : new ListView.builder(
//               itemCount: _userDetails.length,
//               itemBuilder: (context, index) {
//                 return new Card(
//                   child: new ListTile(
//                  //   title: new Text(_userDetails[index].firstName + ' ' + _userDetails[index].lastName),
//                     title: new Text(_userDetails[index].firstName ),
//                   ),
//                   margin: const EdgeInsets.all(0.0),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   onSearchTextChanged(String text) async {
//     _searchResult.clear();
//     if (text.isEmpty) {
//       setState(() {});
//       return;
//     }
//
//     _userDetails.forEach((userDetail) {
//       if (userDetail.firstName.contains(text.toLowerCase()) || userDetail.firstName.contains(text))
//     //  if (userDetail.firstName.contains(text) || userDetail.lastName.contains(text))
//         _searchResult.add(userDetail);
//     });
//
//     setState(() {});
//   }
// }
//
//
// class UserDetails {
//   final int id;
//   final String firstName, lastName;
//
//   UserDetails({this.id, this.firstName, this.lastName,});
//
//   factory UserDetails.fromJson(Map<String, dynamic> json) {
//     return new UserDetails(
//       id: json['id'],
//       firstName: json['name'],
//       lastName: json['username'],
//     );
//   }
// }


