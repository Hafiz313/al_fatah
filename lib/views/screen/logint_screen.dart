import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:inventory_app/Controllers/FYearController.dart';
import 'package:inventory_app/Controllers/LoginLocationController.dart';
import 'package:inventory_app/Controllers/login_repository.dart';
import 'package:inventory_app/core/datamodels/BrandModels.dart';
import 'package:inventory_app/core/datamodels/FyearModels.dart';
import 'package:inventory_app/core/datamodels/LocationModels.dart';
import 'package:inventory_app/utils/app_color.dart';
import 'package:inventory_app/utils/app_constant.dart';
import 'package:inventory_app/utils/app_sizes.dart';
import 'package:inventory_app/utils/preference_utils.dart';
import 'package:inventory_app/views/screen/product_screen.dart';
import 'package:inventory_app/views/widgets/MyTextFormField.dart';
import 'package:inventory_app/views/widgets/app_buttons.dart';
import 'package:inventory_app/views/widgets/app_text_styles.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../core/datamodels/LocationModels.dart';
import '../base_view.dart';
import 'dart:convert';
import 'SearchListExample.dart';
import 'demo.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> signInForm = GlobalKey<FormState>();
  bool _isVisible = false;
  static final TextEditingController _userNameController = new TextEditingController();
  static final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _locationControllerText = new TextEditingController();
  final LocationController _loginLocationController = Get.put(LocationController());
  final FYearController _fYearController =Get.put(FYearController());
  List<LocationModels> searchLocationResult =[];
  String _searchLocationText = "";
  String selectLocationStr= "Select Location";
  String selectLocationCode= "";
  bool isLocationSearching= false;


  List<LocationModels> LocationList;

  String selectYearStr= "Select Year";
  String selectYearCode;
  bool isYearView=false;

  ProgressDialog pr;

  _LoginScreenState() {
    _locationControllerText.addListener(() {
      if (_locationControllerText.text.isEmpty) {
        setState(() {
          _searchLocationText = "";
        });
      } else {
        setState(() {
          _searchLocationText = _locationControllerText.text;
        });
      }
    });
  }



  @override
  void initState() {
    // TODO: implement initState
  //  getList();
    super.initState();
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
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(
              horizontal: AppSizes.appVerticalLg * 0.6
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: AppSizes.appVerticalLg *1.5,),
              InkWell(
                onTap: (){
                  print("=============isBrand:${Repository.isBrand}===isCategory:${Repository.isCategory}===isSubCategory:${Repository.isSubCategory}======");

                },
                child: Container(
                  height: AppSizes.appVerticalLg * 2,
                  width: AppSizes.appHorizontalLg * 3,
                  child: Image(
                    image: AssetImage("images/logo.png"),
                  ),
                ),
              ),
              Form(
                key: signInForm,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Username",style: simpleText(fontSize: 15,color: kAppPrimaryColor),)),
                    SizedBox(height: AppSizes.appVerticalLg *.1,),


                    MyTextFormField(
                      hintText: "Enter Username",
                      validator: (value) => value.isEmpty ? "Empty"
                          : null,
                      isPassword: false,
                      isPhone: false,
                      isEmail: true,
                      autoFocus: false,
                      controller: _userNameController,
                    ),
                    SizedBox(height: AppSizes.appVerticalLg *.2,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(kPassword,style: simpleText(fontSize: 15,color:kAppPrimaryColor),)),
                    SizedBox(height: AppSizes.appVerticalLg *.1,),
                    MyTextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 3) {
                          return 'Length should be greater than 4';
                        }

                        return null;
                      },
                      isPhone: false,
                      icon: IconButton(
                        icon: Icon(
                          _isVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: kAppPrimaryColor,

                        ),
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                      ),
                      hintText: "Enter Password",
                      isPassword: !_isVisible,
                      isEmail: false,
                      autoFocus: false,
                      controller: _passwordController,

                    ),
                    SizedBox(height: AppSizes.appVerticalLg *.2,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Location",style: simpleText(fontSize: 15,color: kAppPrimaryColor),)),
                    SizedBox(height: AppSizes.appVerticalLg *.1,),

                    isLocationSearching? Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                      child: TextField(
                        controller: _locationControllerText,
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
                                  isLocationSearching =!isLocationSearching;
                                });
                              },
                              child: Icon(Icons.arrow_drop_up)),
                          focusedBorder: _outlineInputBorder(Colors.blue),
                          enabledBorder: _outlineInputBorder(kAppPrimaryColor),
                          border: _outlineInputBorder(kAppPrimaryColor),
                          errorBorder: _outlineInputBorder(kRedColor),
                          focusedErrorBorder: _outlineInputBorder(kRedColor),
                          hintText: "Search",
                          labelText: selectLocationStr,
                          errorMaxLines: 1,
                          hintStyle: TextStyle(color: kPrimaryTextColor),
                        ),
                        onChanged: barndSearchOperation,
                      ),
                    )
                        :InkWell(
                      onTap: (){
                        setState(() {
                          isLocationSearching =!  isLocationSearching;
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
                            Text("$selectLocationStr",overflow: TextOverflow.ellipsis,style: simpleText(color: kPrimaryTextColor,fontSize: 15,),),
                            isLocationSearching? Icon(Icons.arrow_drop_up,size: 30,color: kPrimaryTextColor,):Icon(Icons.arrow_drop_down,size: 30,color: kPrimaryTextColor,)
                          ],),
                      ),
                    ),
                    isLocationSearching? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              selectLocationStr= "Select Brand";
                              selectLocationCode= "";
                              _locationControllerText.clear();

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
                            child: searchLocationResult.isNotEmpty  || _locationControllerText.text.isNotEmpty
                                ? new ListView.builder(
                              shrinkWrap: true,

                              itemCount: searchLocationResult.length,
                              itemBuilder: (BuildContext context, int index) {
                                //   String listData = searchresult[index];
                                return InkWell(
                                  onTap:(){
                                    setState(() {
                                      isLocationSearching =! isLocationSearching;
                                      selectLocationStr=searchLocationResult[index].code +" | "+searchLocationResult[index].name;
                                      selectLocationCode= searchLocationResult[index].code;

                                    });

                                  },
                                  child: new ListTile(
                                    title: new Text(searchLocationResult[index].code+" | "+searchLocationResult[index].name),
                                  ),
                                );
                              },
                            )
                                : new ListView.builder(
                              shrinkWrap: true,
                              itemCount: _loginLocationController.locationList.length,
                              itemBuilder: (BuildContext context, int index) {
                                // String listData = widget.brandList[index].name;
                                return InkWell(
                                  onTap:(){
                                    setState(() {
                                      isLocationSearching =!isLocationSearching;
                                      selectLocationStr= _loginLocationController.locationList[index].code+" | "+ _loginLocationController.locationList[index].name;
                                      selectLocationCode=  _loginLocationController.locationList[index].code;
                                    });

                                  },
                                  child: new ListTile(
                                    title: new Text(_loginLocationController.locationList[index].code+" | "+_loginLocationController.locationList[index].name),
                                  ),
                                );
                              },
                            )),
                      ],
                    ):Container(),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(width: 1,color: kAppPrimaryColor),
                    //   ),
                    //   child:!_loginLocationController.isLoading.value? SearchableDropdown(
                    //     items: _loginLocationController.locationList.map((item) {
                    //       return new DropdownMenuItem<LocationModels>(
                    //           child: Text(item.name)
                    //           , value: item);
                    //     }).toList(),
                    //     isExpanded: true,
                    //     value: selectedLocationValue,
                    //     isCaseSensitiveSearch: true,
                    //     searchHint: new Text(
                    //       'Select ',
                    //       style: new TextStyle(fontSize: 20,color: Colors.blue),
                    //     ),
                    //     onChanged: (value) {
                    //       setState(() {
                    //         selectedLocationValue = value;
                    //         print("=======selectedValue :$selectedLocationValue===");
                    //       });
                    //     },
                    //   ):Container(
                    //     height: 50,
                    //     child: SpinKitWave(color: kAppPrimaryColor,size: AppSizes.appVerticalLg *0.55,),
                    //   ),
                    //   // Row(
                    //   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   //   children: [
                    //   //   Text("$selectLocation",style: simpleText(color: kPrimaryTextColor,fontSize: 15,),),
                    //   //   Icon(Icons.arrow_drop_down,size: 30,color: kPrimaryTextColor,)
                    //   // ],),
                    // ),
                    SizedBox(height: AppSizes.appVerticalLg *.2,),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Year",style: simpleText(fontSize: 15,color: kAppPrimaryColor),)),
                    SizedBox(height: AppSizes.appVerticalLg *.1,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          isYearView=!isYearView;
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
                            Text("$selectYearStr",style: simpleText(color: kPrimaryTextColor,fontSize: 15,),),
                            isYearView? Icon(Icons.arrow_drop_up,size: 30,color: kPrimaryTextColor,):Icon(Icons.arrow_drop_down,size: 30,color: kPrimaryTextColor,)
                          ],),
                      ),
                    ),
                    isYearView?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              selectYearStr= "Select Year";
                              selectYearCode=null;
                              isYearView=false;
                            });

                          },
                          child: Container(
                            width: 100,
                            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                            //     color: kAppPrimaryColor
                            // ),
                            margin: EdgeInsets.only(top: 10),
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
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _fYearController.fYearList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isYearView = !isYearView;
                                      selectYearStr=_fYearController.fYearList[index].description;
                                      selectYearCode= _fYearController.fYearList[index].code;
                                      print("======$selectYearStr=====$selectYearCode======");
                                    });
                                  },
                                  child: ListTile(
                                    title:
                                    Text(_fYearController.fYearList[index].description),
                                  ));
                            },
                          ),
                        ),
                      ],
                    ):Container(),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(width: 1,color: kAppPrimaryColor),
                    //   ),
                    //   child:!_fYearController.isLoading.value? SearchableDropdown(
                    //     items: _fYearController.fYearList.map((item) {
                    //       return new DropdownMenuItem<FyearModels>(
                    //           child: Text(item.code)
                    //           , value: item);
                    //     }).toList(),
                    //     isExpanded: true,
                    //     value: selectedFYearValue,
                    //     isCaseSensitiveSearch: true,
                    //     searchHint: new Text(
                    //       'Select ',
                    //       style: new TextStyle(fontSize: 20,color: Colors.blue),
                    //     ),
                    //     onChanged: (value) {
                    //       setState(() {
                    //         selectedFYearValue = value;
                    //         print("=======selectedFYearValue :${selectedFYearValue.code}===");
                    //       });
                    //     },
                    //   ):Container(
                    //     height: 50,
                    //     child: SpinKitWave(color: kAppPrimaryColor,size: AppSizes.appVerticalLg *0.55,),
                    //   ),
                    //   // Row(
                    //   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   //   children: [
                    //   //   Text("$selectLocation",style: simpleText(color: kPrimaryTextColor,fontSize: 15,),),
                    //   //   Icon(Icons.arrow_drop_down,size: 30,color: kPrimaryTextColor,)
                    //   // ],),
                    // ),
                    SizedBox(height: AppSizes.appVerticalLg *.4,),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.appHorizontalLg * 1
                      ),
                      width: double.infinity,
                      child:roundRectangleBtn(txt: kLogIn,textColor: kPrimaryTextColor,bgColor: kAppPrimaryColor,onPressed: () async {

                        //
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SearchListDemo(
                        //         )));

                        if(signInForm.currentState.validate() && selectLocationCode.isNotEmpty && selectYearCode.isNotEmpty){


                          pr.show();
                          // bool isLogin = await Repository.getLogin(
                          //     "${_userNameController.value.text.toString()}",
                          //     "${_passwordController.value.text.toString()}",
                          //     "$selectLocationCode",
                          //     "$selectYearCode");
                          bool isLogin = await Repository.getLoginAndData(
                              "${_userNameController.value.text.toString()}",
                              "${_passwordController.value.text.toString()}",
                              "$selectLocationCode",
                              "$selectYearCode");


                          // if(isLogin && Repository.isBrand.value && Repository.isCategory.value && Repository.isSubCategory.value ){
                          if(isLogin){
                            //  print("======isLogin$isLogin=======isBrand:${Repository.isBrand}===isCategory:${Repository.isCategory}===isSubCategory:${Repository.isSubCategory}======");
                            setState(() {
                              PreferenceUtils.setString(kShareLoginLocation,selectLocationCode);
                              PreferenceUtils.setString(kShareLoginFyear,selectYearCode);
                            });
                            pr.hide();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductScreen(
                                    )));

                            //
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SearchListDemo(
                            //         )));
                            Get.snackbar(
                              "Login alert",
                              "Successfully login",
                              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                              dismissDirection: SnackDismissDirection.HORIZONTAL,
                              duration: Duration(seconds: 4),
                            );

                          }
                          else{
                            print("----------------not ok------------------");
                            pr.hide();
                            Get.snackbar(
                              "Login alert",
                              "Error",
                              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                              dismissDirection: SnackDismissDirection.HORIZONTAL,
                              duration: Duration(seconds: 4),
                            );

                          }
                        }
                        else{
                          Get.snackbar(
                            "",
                            "",
                            borderRadius: 20.0,
                            borderWidth: 1.0,
                            titleText: Text("Please file all inputs",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)
                            ,
                            borderColor: kAppPrimaryColor,
                            margin: EdgeInsets.only(top: 0, left: 10, right: 10,bottom: 0),
                            dismissDirection: SnackDismissDirection.VERTICAL,
                            snackPosition: SnackPosition.TOP,
                            duration: Duration(seconds: 4),
                          );
                        }

                      }),
                    ),
                    SizedBox(height: 20,)

                  ],
                ),

              ),

            ],
          ),
        ),
      )
    );}
  OutlineInputBorder _outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1.5, color: color?? kPrimaryTextColor),
    );
  }
  void barndSearchOperation(String searchText) {
    searchLocationResult.clear();
    // if (_isSearching != null) {
    for (int i = 0; i < _loginLocationController.locationList.length; i++) {
      LocationModels data=  LocationModels(name:  _loginLocationController.locationList[i].name,code:  _loginLocationController.locationList[i].code);
      if (data.code.toLowerCase().contains(searchText.toUpperCase()) || data.code.toLowerCase().contains(searchText.toLowerCase()) || data.name.toLowerCase().contains(searchText.toLowerCase()) || data.name.toLowerCase().contains(searchText.toUpperCase())) {
        searchLocationResult.add(data);
      }
    }
    //  }
  }



}




