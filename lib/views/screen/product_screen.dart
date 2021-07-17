import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inventory_app/Controllers/BrandController.dart';
import 'package:inventory_app/Controllers/CategoryController.dart';
import 'package:inventory_app/Controllers/InverotyReslutsController.dart';
import 'package:inventory_app/Controllers/LoginLocationController.dart';
import 'package:inventory_app/Controllers/SubCategoryController.dart';
import 'package:inventory_app/Controllers/login_repository.dart';
import 'package:inventory_app/core/datamodels/BrandModels.dart';
import 'package:inventory_app/core/datamodels/CategoryModels.dart';
import 'package:inventory_app/core/datamodels/FyearModels.dart';
import 'package:inventory_app/core/datamodels/InventoryResultModel.dart';
import 'package:inventory_app/core/datamodels/LocationModels.dart';
import 'package:inventory_app/core/datamodels/SubcategoryModel.dart';
import 'package:inventory_app/utils/app_color.dart';
import 'package:inventory_app/utils/app_constant.dart';
import 'package:inventory_app/utils/app_sizes.dart';
import 'package:inventory_app/utils/preference_utils.dart';
import 'package:inventory_app/views/screen/item_select_screen.dart';
import 'package:inventory_app/views/screen/logint_screen.dart';
import 'package:inventory_app/views/widgets/MyTextFormField.dart';
import 'package:inventory_app/views/widgets/app_buttons.dart';
import 'package:inventory_app/views/widgets/app_text_styles.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/datamodels/LocationModels.dart';
import '../base_view.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'SearchListExample.dart';
import 'demo.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  GlobalKey<FormState> productForm = GlobalKey<FormState>();
  static final TextEditingController _itemNameController = new TextEditingController();
  final TextEditingController _brandControllerText = new TextEditingController();
  final TextEditingController _categoryControllerText = new TextEditingController();
  final TextEditingController _subCategoryControllerText = new TextEditingController();
  // List<BrandModels> brandList;
  //List<CategoryModels> categoryList;
  //List<SubcategoryModels> subCategoryList;


  final BrandController _brandController = Get.put(BrandController());
  final CategoryController _categoryController = Get.put(CategoryController());
  final SubCategoryController _subCategoryController = Get.put(SubCategoryController());
  ProgressDialog pr;
  List<int> matchListIndex=[];

 // BrandModels selectBrandValue;
 //CategoryModels selectCategoryValue;
 // SubcategoryModels selectSubcategoryValue;


  String selectBrandStr= "Select Brand";
  String selectBrandCode= "";
  bool isBrandSearching= false;


  String selectCategoryStr= "Select Category";
  String selectCategoryCode= "";
  bool isCategoryView=false;


  String selectSubcategoryStr= "Select Subcategory";
  String selectSubcategoryCode= "";
  bool isSubcategoryView=false;


 bool isSubcategoryBeforeMatch=false;




  List<BrandModels> searchBrandResult =[];
  List <CategoryModels> searchCategoryResult =[];
  List searchSubCategoryResult = [];

  String _searchBrandText = "";
  String _searchCategoryText = "";



  void dispose() {
    // TODO: implement dispose
    _itemNameController.clear();
    super.dispose();
  }


  @override
  void initState() {
 //   getShareList();
  //  getList();
    super.initState();
  }
  _ProductScreenState() {
    _brandControllerText.addListener(() {
      if (_brandControllerText.text.isEmpty) {
        setState(() {
      //    isBrandSearching = false;
          _searchBrandText = "";
        });
      } else {
        setState(() {
         // isBrandSearching = true;
          _searchBrandText = _brandControllerText.text;
        });
      }
    });

    _categoryControllerText.addListener(() {
      if (_categoryControllerText.text.isEmpty) {
        setState(() {
          //    isBrandSearching = false;
          _searchCategoryText = "";
        });
      } else {
        setState(() {
          // isBrandSearching = true;
          _searchCategoryText = _categoryControllerText.text;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
      backgroundColor: Colors.white,
      progressWidget: Container(
          width: double.infinity,
          child: Center(child: SpinKitFadingCircle(color: Colors.black))),
    );
    AppSizes().init(context);
    return BaseScaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen(
                          )));
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  await preferences.clear();


                 },
                child: Container(
                  width: 110,
                  margin: EdgeInsets.only(top: 10,right: 10),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: kAppPrimaryColor,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.clear,size: 18,color: kAppPrimaryColor,),
                      SizedBox(width: 5,),
                      Text("Logout",style: TextStyle(color: kAppPrimaryColor,fontSize: 18),),
                    ],
                  ),
                ),
              ),
              Container(
                height: AppSizes.appVerticalLg * 2,
                width: double.infinity,
                child: Image(
                  image: AssetImage("images/logo.png"),
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Center(child: Text("Search Product",style: simpleText(fontSize: 20,color: kAppPrimaryColor),))),
              SizedBox(height: 30,),
              Container(
                padding:  EdgeInsets.symmetric(
                    horizontal: AppSizes.appVerticalLg * 0.5
                ),
                child: Form(
                  key: productForm,
                  child: Center(
                    child: Column(
                      children: [

                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Brand",style: simpleText(fontSize: 15,color: kAppPrimaryColor),)),
                        SizedBox(height: AppSizes.appVerticalLg *.1,),

                        isBrandSearching? Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                          child: TextField(
                            controller: _brandControllerText,
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
                                      isBrandSearching =!isBrandSearching;
                                    });
                                  },
                                  child: Icon(Icons.arrow_drop_up)),
                              focusedBorder: _outlineInputBorder(Colors.blue),
                              enabledBorder: _outlineInputBorder(kAppPrimaryColor),
                              border: _outlineInputBorder(kAppPrimaryColor),
                              errorBorder: _outlineInputBorder(kRedColor),
                              focusedErrorBorder: _outlineInputBorder(kRedColor),
                              hintText: "Search",
                              labelText: selectBrandStr,
                              errorMaxLines: 1,
                              hintStyle: TextStyle(color: kPrimaryTextColor),
                            ),
                            onChanged: barndSearchOperation,
                          ),
                        )
                            :InkWell(
                          onTap: (){
                            setState(() {
                              isBrandSearching =!  isBrandSearching;
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
                                Text("$selectBrandStr",style: simpleText(color: kPrimaryTextColor,fontSize: 15,),),
                                isBrandSearching? Icon(Icons.arrow_drop_up,size: 30,color: kPrimaryTextColor,):Icon(Icons.arrow_drop_down,size: 30,color: kPrimaryTextColor,)
                              ],),
                          ),
                        ),
                        isBrandSearching? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                   selectBrandStr= "Select Brand";
                                   selectBrandCode= "";
                                   _brandControllerText.clear();

                                 //  isBrandSearching= false;
                                });


                              },
                              child: Container(
                                width: 100,
                                // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                //     color: kAppPrimaryColor
                                // ),
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.clear,color:kAppPrimaryColor),
                                    SizedBox(width: 5,),
                                    Text("Clear",style: TextStyle(color: kAppPrimaryColor,fontSize: 20),)
                                  ],),
                              ),
                            ),
                            Container(
                                height: 300,
                                child: searchBrandResult.isNotEmpty  || _brandControllerText.text.isNotEmpty
                                    ? new ListView.builder(
                                  shrinkWrap: true,

                                  itemCount: searchBrandResult.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    //   String listData = searchresult[index];
                                    return InkWell(
                                      onTap:(){
                                        setState(() {
                                          isBrandSearching =! isBrandSearching;
                                          selectBrandStr= searchBrandResult[index].name;
                                          selectBrandCode= searchBrandResult[index].code;

                                        });

                                      },
                                      child: new ListTile(
                                        title: new Text(searchBrandResult[index].name),
                                      ),
                                    );
                                  },
                                )
                                    : new ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _brandController.brandList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    // String listData = widget.brandList[index].name;
                                    return InkWell(
                                      onTap:(){
                                        setState(() {
                                          isBrandSearching =!isBrandSearching;
                                          selectBrandStr=  _brandController.brandList[index].name;
                                          selectBrandCode=  _brandController.brandList[index].code;
                                        });

                                      },
                                      child: new ListTile(
                                        title: new Text(_brandController.brandList[index].name),
                                      ),
                                    );
                                  },
                                )),
                          ],
                        ):Container(),
                      SizedBox(height: AppSizes.appVerticalLg *.2,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Category",style: simpleText(fontSize: 15,color:kAppPrimaryColor),)),
                    SizedBox(height: AppSizes.appVerticalLg *.1,),

                        isCategoryView? Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                          child: TextField(
                            controller: _categoryControllerText,
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
                                      isCategoryView =!isCategoryView;
                                    });
                                  },
                                  child: Icon(Icons.arrow_drop_up)),
                              focusedBorder: _outlineInputBorder(Colors.blue),
                              enabledBorder: _outlineInputBorder(kAppPrimaryColor),
                              border: _outlineInputBorder(kAppPrimaryColor),
                              errorBorder: _outlineInputBorder(kRedColor),
                              focusedErrorBorder: _outlineInputBorder(kRedColor),
                              hintText: "Search",
                              labelText: selectCategoryStr,
                              errorMaxLines: 1,
                              hintStyle: TextStyle(color: kPrimaryTextColor),
                            ),
                            onChanged: categorySearchOperation,
                          ),
                        )
                            :InkWell(
                          onTap: (){
                            setState(() {
                              isCategoryView =!  isCategoryView;
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
                                Text("$selectCategoryStr",style: simpleText(color: kPrimaryTextColor,fontSize: 15,),),
                                isCategoryView? Icon(Icons.arrow_drop_up,size: 30,color: kPrimaryTextColor,):Icon(Icons.arrow_drop_down,size: 30,color: kPrimaryTextColor,)
                              ],),
                          ),
                        ),

                        isCategoryView? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                   selectCategoryStr= "Select Category";
                                   selectCategoryCode= "";
                                   _categoryControllerText.clear();
                                   matchListIndex.clear();
                                   isSubcategoryBeforeMatch=false;

                                  // isCategoryView=false;

                                });

                              },
                              child: Container(
                                width: 100,
                                // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                //     color: kAppPrimaryColor
                                // ),
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.clear,color:kAppPrimaryColor),
                                    SizedBox(width: 5,),
                                    Text("Clear",style: TextStyle(color: kAppPrimaryColor,fontSize: 20),)
                                  ],),
                              ),
                            ),
                            Container(
                                height: 300,
                                child: searchCategoryResult.length != 0 || _categoryControllerText.text.isNotEmpty
                                    ? new ListView.builder(
                                  shrinkWrap: true,

                                  itemCount: searchCategoryResult.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    //   String listData = searchresult[index];
                                    return InkWell(
                                      onTap:(){
                                        setState(() {
                                          isCategoryView =! isCategoryView;
                                          selectCategoryStr= searchCategoryResult[index].name;
                                          selectCategoryCode= searchCategoryResult[index].code;
                                          selectSubcategoryStr= "Select Subcategory";
                                          isSubcategoryBeforeMatch=true;
                                          matchListIndex.clear();
                                        });
                                        for(int i=0; i <=_categoryController.categoryList.length; i++){
                                          if( _subCategoryController.list[i].type==selectCategoryCode){
                                            matchListIndex.add(i);
                                            //matchList.add(i);
                                            print("========selectCategoryValue :${ _subCategoryController.list[i].name}========");
                                          }
                                        }

                                      },
                                      child: new ListTile(
                                        title: new Text(searchCategoryResult[index].name),
                                      ),
                                    );
                                  },
                                )
                                    : new ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _categoryController.categoryList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    // String listData = widget.brandList[index].name;
                                    return InkWell(
                                      onTap:(){
                                        setState(() {
                                          isCategoryView =!  isCategoryView;
                                          selectCategoryStr=  _categoryController.categoryList[index].name;
                                          selectCategoryCode=   _categoryController.categoryList[index].code;
                                          selectSubcategoryStr= "Select Subcategory";
                                          isSubcategoryBeforeMatch=true;
                                          matchListIndex.clear();
                                        });
                                        for(int i=0; i <=_categoryController.categoryList.length; i++){
                                          if( _subCategoryController.list[i].type==selectCategoryCode){
                                            matchListIndex.add(i);
                                            //matchList.add(i);
                                            print("========selectCategoryValue :${ _subCategoryController.list[i].name}========");
                                          }
                                        }

                                      },
                                      child: new ListTile(
                                        title: new Text(_categoryController.categoryList[index].name),
                                      ),
                                    );
                                  },
                                )),
                          ],
                        ):Container(),
                        SizedBox(height: AppSizes.appVerticalLg *.2,),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Sub Category",style: simpleText(fontSize: 15,color: kAppPrimaryColor),)),
                        SizedBox(height: AppSizes.appVerticalLg *.1,),
                        InkWell(
                          onTap: (){
                            setState(() {
                              isSubcategoryView=!isSubcategoryView;
                            });


                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1,color: kAppPrimaryColor),),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("$selectSubcategoryStr",style: simpleText(color: kPrimaryTextColor,fontSize: 15,),),
                                isSubcategoryView? Icon(Icons.arrow_drop_up,size: 30,color: kPrimaryTextColor,):Icon(Icons.arrow_drop_down,size: 30,color: kPrimaryTextColor,)
                              ],),
                          ),
                        ),
                        isSubcategoryView?
                       isSubcategoryBeforeMatch?

                        Container(
                            child: matchListIndex.isNotEmpty?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                       selectSubcategoryStr= "Select Subcategory";
                                       selectSubcategoryCode= "";
                                       isSubcategoryView=false;
                                      //  isBrandSearching= false;
                                    });


                                  },
                                  child: Container(
                                    width: 100,
                                    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                    //     color: kAppPrimaryColor
                                    // ),
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.clear,color:kAppPrimaryColor),
                                        SizedBox(width: 5,),
                                        Text("Clear",style: TextStyle(color: kAppPrimaryColor,fontSize: 20),)
                                      ],),
                                  ),
                                ),
                                Container(
                                  height: 300,
                                  child: ListView.builder(
                                    itemCount: matchListIndex.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isSubcategoryView = !isSubcategoryView;
                                              selectSubcategoryStr=_subCategoryController.list[matchListIndex[index]].name;
                                              selectSubcategoryCode= _subCategoryController.list[matchListIndex[index]].code;
                                            });
                                          },
                                          child: ListTile(
                                            title:
                                            Text(_subCategoryController.list[matchListIndex[index]].name),
                                          ));
                                    },
                                  ),
                                ),
                              ],
                            ):Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Center(child: Text("No Data")),)):

                        Container(
                            child: _subCategoryController.list.isNotEmpty?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      selectSubcategoryStr= "Select Subcategory";
                                      selectSubcategoryCode= "";
                                      isSubcategoryView=false;

                                      //  isBrandSearching= false;
                                    });


                                  },
                                  child: Container(
                                    width: 100,
                                    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                    //     color: kAppPrimaryColor
                                    // ),
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.clear,color:kAppPrimaryColor),
                                        SizedBox(width: 5,),
                                        Text("Clear",style: TextStyle(color: kAppPrimaryColor,fontSize: 20),)
                                      ],),
                                  ),
                                ),
                                Container(
                                  height: 300,
                                  child: ListView.builder(
                                    itemCount: _subCategoryController.list.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isSubcategoryView = !isSubcategoryView;
                                              selectSubcategoryStr=_subCategoryController.list[index].name;
                                              selectSubcategoryCode= _subCategoryController.list[index].code;
                                            });
                                          },
                                          child: ListTile(
                                            title:
                                            Text(_subCategoryController.list[index].name),
                                          ));
                                    },
                                  ),
                                ),
                              ],
                            ):Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Center(child: Text("No Data")),)):Container(),


                        SizedBox(height: AppSizes.appVerticalLg *.2,),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Item Name",style: simpleText(fontSize: 15,color: kAppPrimaryColor),)),
                        SizedBox(height: AppSizes.appVerticalLg *.1,),
                        MyTextFormField(
                          hintText: "Enter item name",
                          validator: (value) => value.isEmpty ? "Empty"
                              : null,
                          isPassword: false,
                          isPhone: false,
                          isEmail: true,
                          autoFocus: false,
                          controller: _itemNameController,

                        ),
                        SizedBox(height: AppSizes.appVerticalLg *.4,),
                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: Container(

                                width: double.infinity,
                                child:roundRectangleBtn(txt: "Search",textColor: Colors.white,bgColor: kAppPrimaryColor,onPressed: () async {
                                  pr.show();
                                  print("=======selectBrandCode$selectBrandCode =====selectCategoryCode:$selectCategoryCode=== selectSubcategoryCode:$selectSubcategoryCode itemName:${_itemNameController.text.toString()}======Fyear=${ PreferenceUtils.getString(kShareLoginFyear)}=====");

                                 var url = Uri.parse(baseUrl+"Inventory?Brand=$selectBrandCode&Category=$selectCategoryCode&SubCategory=$selectSubcategoryCode&ItemName=${_itemNameController.text.toString()}&Fyear=${ PreferenceUtils.getString(kShareLoginFyear)}&pagesize=50&pageno=1");
                                   // var url = Uri.parse("http://cserp.southeastasia.cloudapp.azure.com:55080/api/Inventory?Brand=&Category=&SubCategory=&ItemName=&Fyear=2020&pagesize=50&pageno=1");
                                  try{
                                    final response = await http.get(url);

                                    var body = json.decode(response.body);
                                    print("===body:$body===========");

                                    //  print(response.body);


                                    if (response.statusCode == 200) {
                                      pr.hide();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => ItemSelectScreen(
                                      //           inventoryResultsList:inventoryResultModelFromJson(body),
                                      //         )));
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SearchListExample(
                                                inventoryResultsList:inventoryResultModelFromJson(body),
                                              )));
                                    }

                                  } catch(e){
                                    print('error $e');

                                  }

                                }),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                     selectBrandStr= "Select Brand";
                                     selectBrandCode= "";
                                     isBrandSearching= false;

                                     selectCategoryStr= "Select Category";
                                     selectCategoryCode= "";
                                     isCategoryView=false;

                                     selectSubcategoryStr= "Select Subcategory";
                                     selectSubcategoryCode= "";
                                     isSubcategoryView=false;
                                     _itemNameController.clear();
                                     isSubcategoryBeforeMatch=false;


                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: AppSizes.appVerticalLg * 0.25,horizontal: AppSizes.appHorizontalLg * 0.6),
                                  width: double.infinity,
                                  alignment:Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: kAppPrimaryColor,
                                    ),
                                  ),
                                  child: Text("Reset",style: TextStyle(color: kAppPrimaryColor),),
                                ),
                              )
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                ),
              ),

            ],
          ),
        )
      )
    );}
  OutlineInputBorder _outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1.5, color: color?? kPrimaryTextColor),
    );
  }
  // void searchOperation(String searchText) {
  //   searchresult.clear();
  //   //if ( isSearching != null) {
  //     for (int i = 0; i < _brandController.brandList.length; i++) {
  //       String data =_brandController. brandList[i].name;
  //       if (data.toLowerCase().contains(searchText.toLowerCase())) {
  //         searchresult.add(data);
  //       }
  //     }
  //  // }
  // }
  void barndSearchOperation(String searchText) {
    searchBrandResult.clear();
    // if (_isSearching != null) {
    for (int i = 0; i < _brandController.brandList.length; i++) {
      BrandModels data=  BrandModels(name: _brandController.brandList[i].name,code: _brandController.brandList[i].code);
    //  String data = _brandController.brandList[i].name;
      if (data.name.toLowerCase().contains(searchText.toLowerCase()) || data.name.toLowerCase().contains(searchText.toUpperCase())) {
        searchBrandResult.add(data);
      }
    }
    //  }
  }
  void categorySearchOperation(String searchText) {
    searchCategoryResult.clear();
     if (isCategoryView!= null) {
    for (int i = 0; i < _categoryController.categoryList.length; i++) {
      CategoryModels date =CategoryModels(name:_categoryController.categoryList[i].name,code: _categoryController.categoryList[i].code );
    //  String name = _categoryController.categoryList[i].name;
      if (date.name.toLowerCase().contains(searchText.toLowerCase()) || date.name.toLowerCase().contains(searchText.toUpperCase())) {
        searchCategoryResult.add(date);
      }
    }
     }
  }
  void subCategorySearchOperation(String searchText) {
    searchSubCategoryResult.clear();
    // if (_isSearching != null) {
    for (int i = 0; i < _subCategoryController.list.length; i++) {
      String data = _subCategoryController.list[i].name;
      if (data.toLowerCase().contains(searchText.toLowerCase()) || data.toLowerCase().contains(searchText.toUpperCase())) {
        searchSubCategoryResult.add(data);
      }
    }
    //  }
  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to quit', textAlign: TextAlign.center),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }
  //
  // openSpokenAlert() {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           backgroundColor: Colors.white,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(20.0))),
  //           contentPadding: EdgeInsets.only(top: 5.0),
  //           content: Container(
  //               height: 330.00,
  //               width: 300.00,
  //               margin: const EdgeInsets.only(
  //                   bottom: 0, left: 25, right: 25, top: 25),
  //               child: Obx(() {
  //                 if (_subCategoryController.isLoading.value) {
  //                   return Container(
  //                     height: 50,
  //                     child: SpinKitWave(color: kAppPrimaryColor,size: AppSizes.appVerticalLg *0.55,),
  //                   );
  //                 }
  //                 return ListView.builder(
  //                   itemCount: _subCategoryController.list.length,
  //                   itemBuilder: (context, index) {
  //                     return GestureDetector(
  //                         onTap: () {
  //                           setState(() {});
  //                           Navigator.of(context).pop();
  //                         },
  //                         child: ListTile(
  //                           title:
  //                           Text(_subCategoryController.list[index].name),
  //                         ));
  //                   },
  //                 );
  //               })),
  //           actions: [
  //             Padding(
  //               padding: const EdgeInsets.only(right: 8.0),
  //               child: TextButton(
  //                   child: Text(
  //                     'Reset',
  //                     style: TextStyle(color: Colors.red),
  //                   ),
  //                   onPressed: () {
  //                     setState(() {});
  //                     Navigator.of(context).pop();
  //                   }),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(right: 8.0),
  //               child: TextButton(
  //                   child: Text(
  //                     'Cancel',
  //                     style: TextStyle(color: Colors.red),
  //                   ),
  //                   onPressed: () {
  //                     setState(() {});
  //                     Navigator.of(context).pop();
  //                   }),
  //             ),
  //           ],
  //         );
  //       });
  // }

  Future<void> getShareList() {

    // var body = json.decode(PreferenceUtils.getString(kShareBrandList));
    // brandList=  brandModelsFromJson(body);
    // print("==========brandList======${brandList.length}=============");
    // var cateGoryBody = json.decode(PreferenceUtils.getString(kShareCateGoryList));
    // categoryList=  categoryModelsFromJson(cateGoryBody);
    // print("==========cateGoryBody======${categoryList.length}=============");
    // var subCateGoryBody = json.decode(PreferenceUtils.getString(kShareCateGoryList));
    // subCategoryList=  subcategoryModelsFromJson(subCateGoryBody);
    // print("==========subCategoryList======${subCategoryList.length}=============");
  }


}


