import 'package:flutter/material.dart';
import 'package:inventory_app/core/datamodels/BrandModels.dart';
import 'package:inventory_app/core/datamodels/InventoryResultModel.dart';
import 'package:inventory_app/utils/app_color.dart';
import 'package:inventory_app/utils/app_sizes.dart';
import '../base_view.dart';

class BrandSearchField extends StatefulWidget {
 // final List<BrandModels> inventoryResultsList;
  final  List<InventoryResultModel> inventoryResultsList;

  const BrandSearchField({Key key, this.inventoryResultsList}) : super(key: key);
  @override
  _BrandSearchFieldState createState() => _BrandSearchFieldState();
}

class _BrandSearchFieldState extends State<BrandSearchField> {
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
              margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
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
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ItemResultScreen(
                        //           inventoryResultModel: widget.inventoryResultsList[index],
                        //         )));
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
                    String listData = _list[index].name;
                    return InkWell(
                      onTap: (){
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ItemResultScreen(
                        //           inventoryResultModel: widget.inventoryResultsList[index],
                        //         )));
                      },
                      child: new ListTile(
                        title: new Text(listData.toString()),
                      ),
                    );
                  },
                ))

          ],
        )

    );}

  void searchOperation(String searchText) {
    searchresult.clear();
    // if (_isSearching != null) {
    for (int i = 0; i < _list.length; i++) {
      String data = _list[i].name;

      if (data.toLowerCase().contains(searchText.toLowerCase()) || data.toLowerCase().contains(searchText.toUpperCase())) {
        print("========data : $data=========");
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


