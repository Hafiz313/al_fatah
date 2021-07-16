import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inventory_app/Controllers/login_repository.dart';
import 'package:inventory_app/core/datamodels/BrandModels.dart';
import 'package:inventory_app/utils/app_color.dart';
import 'package:inventory_app/utils/app_constant.dart';
import 'package:inventory_app/utils/preference_utils.dart';
import 'package:inventory_app/views/widgets/app_text_styles.dart';

class SearchListDemo extends StatefulWidget {
  final   List<BrandModels> brandList;
  const SearchListDemo({Key key, this.brandList}) : super(key: key);
  @override
  _SearchListDemoState createState() => new _SearchListDemoState();
}

class _SearchListDemoState extends State<SearchListDemo> {
  final TextEditingController _controller = new TextEditingController();
  String _searchText = "Select Brand";
  List searchresult = [];
  @override
  void initState() {
    super.initState();
    Repository.isSearching = false;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Repository.isSearching?

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
            child: TextField(
              controller: _controller,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: kPrimaryTextColor,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                suffixIcon: InkWell(
                    onTap: (){
                      setState(() {
                        Repository.isSearching =!  Repository.isSearching;
                      });
                    },
                    child: Icon(Icons.arrow_drop_up)),
                focusedBorder: _outlineInputBorder(Colors.blue),
                enabledBorder: _outlineInputBorder(kAppPrimaryColor),
                border: _outlineInputBorder(kAppPrimaryColor),
                errorBorder: _outlineInputBorder(kRedColor),
                focusedErrorBorder: _outlineInputBorder(kRedColor),
                hintText: "Search",
                errorMaxLines: 1,
                hintStyle: TextStyle(color: kPrimaryTextColor),
              ),
              onChanged: searchOperation,
            ),
          )
              :InkWell(
            onTap: (){
              setState(() {
                Repository.isSearching =!  Repository.isSearching;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1,color: kAppPrimaryColor),
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$_searchText",style: simpleText(color: kPrimaryTextColor,fontSize: 15,),),
                  Repository.isSearching? Icon(Icons.arrow_drop_up,size: 30,color: kPrimaryTextColor,):Icon(Icons.arrow_drop_down,size: 30,color: kPrimaryTextColor,)
                ],),
            ),
          ),
          Repository.isSearching? Container(
            height: 300,
              child: searchresult.length != 0 || _controller.text.isNotEmpty
                  ? new ListView.builder(
                shrinkWrap: true,
                itemCount: searchresult.length,
                itemBuilder: (BuildContext context, int index) {
               //   String listData = searchresult[index];
                  return InkWell(
                    onTap:(){
                      setState(() {
                        Repository.isSearching =!  Repository.isSearching;
                        _searchText= searchresult[index];
                      });

                    },
                    child: new ListTile(
                      title: new Text(searchresult[index]),
                    ),
                  );
                },
              )
                  : new ListView.builder(
                shrinkWrap: true,
                itemCount: widget.brandList.length,
                itemBuilder: (BuildContext context, int index) {
                 // String listData = widget.brandList[index].name;
                  return InkWell(
                    onTap:(){
                      setState(() {
                        Repository.isSearching =!  Repository.isSearching;
                        _searchText=  widget.brandList[index].name;
                       Repository.strCode=  widget.brandList[index].code;
                      });

                    },
                    child: new ListTile(
                      title: new Text(widget.brandList[index].name),
                    ),
                  );
                },
              )):Container()
        ],
      ),
    );
  }

  // Widget buildAppBar(BuildContext context) {
  //   return new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
  //     new IconButton(
  //       icon: icon,
  //       onPressed: () {
  //         setState(() {
  //           if (this.icon.icon == Icons.search) {
  //             this.icon = new Icon(
  //               Icons.close,
  //               color: Colors.white,
  //             );
  //             this.appBarTitle = new TextField(
  //               controller: _controller,
  //               style: new TextStyle(
  //                 color: Colors.white,
  //               ),
  //               decoration: new InputDecoration(
  //                   prefixIcon: new Icon(Icons.search, color: Colors.white),
  //                   hintText: "Search...",
  //                   hintStyle: new TextStyle(color: Colors.white)),
  //               onChanged: searchOperation,
  //             );
  //             _handleSearchStart();
  //           } else {
  //             _handleSearchEnd();
  //           }
  //         });
  //       },
  //     ),
  //   ]);
  // }

  // void _handleSearchStart() {
  //   setState(() {
  //     _isSearching = true;
  //   });
  // }
  //
  // void _handleSearchEnd() {
  //   setState(() {
  //     this.icon = new Icon(
  //       Icons.search,
  //       color: Colors.white,
  //     );
  //     this.appBarTitle = new Text(
  //       "Search Sample",
  //       style: new TextStyle(color: Colors.white),
  //     );
  //     _isSearching = false;
  //     _controller.clear();
  //   });
  // }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (  Repository.isSearching != null) {
      for (int i = 0; i < widget.brandList.length; i++) {
        String data =widget. brandList[i].name;
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }
  OutlineInputBorder _outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1.5, color: color?? kPrimaryTextColor),
    );
  }
}