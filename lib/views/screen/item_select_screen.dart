import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:inventory_app/Controllers/InverotyReslutsController.dart';
import 'package:inventory_app/core/datamodels/FyearModels.dart';
import 'package:inventory_app/core/datamodels/InventoryResultModel.dart';
import 'package:inventory_app/core/datamodels/LocationModels.dart';
import 'package:inventory_app/utils/app_color.dart';
import 'package:inventory_app/utils/app_sizes.dart';
import 'package:inventory_app/views/screen/item_result_screen.dart';
import 'package:inventory_app/views/widgets/MyTextFormField.dart';
import 'package:inventory_app/views/widgets/app_text_styles.dart';

import '../../core/datamodels/LocationModels.dart';
import '../base_view.dart';


class ItemSelectScreen extends StatefulWidget {
  final  List<InventoryResultModel> inventoryResultsList;
  const ItemSelectScreen({Key key, this.inventoryResultsList}) : super(key: key);
  @override
  _ItemSelectScreenState createState() => _ItemSelectScreenState();
}

class _ItemSelectScreenState extends State<ItemSelectScreen> {
 // static final TextEditingController _searchItemController = new TextEditingController();
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> _list;
  List searchresult = new List();


  @override
  void initState() {
    // TODO: implement initState
    _list = List();
    _list=widget.inventoryResultsList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return BaseScaffold(
      body: Column(
        children: [
          Container(
            height: AppSizes.appVerticalLg * 2,
            width: AppSizes.appHorizontalLg * 3,
            child: Image(
              image: AssetImage("images/logo.png"),
            ),
          ),
      Container(
      margin: EdgeInsets.only(top:0,bottom: 10,left: 20,right: 10),
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
          suffixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
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
    ),
          Flexible(
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
              ))
          // Expanded(
          //   child: Container(
          //     padding: EdgeInsets.symmetric(vertical: 20),
          //     child: widget.inventoryResultsList.length >1 ? ListView.builder(
          //       itemCount: widget.inventoryResultsList.length,
          //       itemBuilder: (context, index) {
          //         return GestureDetector(
          //             onTap: () {
          //               setState(() {});
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => ItemResultScreen(
          //                         inventoryResultModel: widget.inventoryResultsList[index],
          //                       )));
          //             },
          //             child: ListTile(
          //               title:
          //               Text(widget.inventoryResultsList[index].name),
          //             ));
          //       },
          //     ):Container(child: Center(child: Text("No Data found")),),
          //   ),
          // ),
        ],
      )

    );}

  void searchOperation(String searchText) {
    searchresult.clear();
   // if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i].name;
        if (data.toLowerCase().contains(searchText.toLowerCase()) || data.toLowerCase().contains(searchText.toUpperCase())) {
          searchresult.add(data);
        }
      }
  //  }
  }

  OutlineInputBorder _outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1.5, color: color?? kPrimaryTextColor),
    );
  }

}


