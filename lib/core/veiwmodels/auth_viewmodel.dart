import 'dart:io';

import "package:flutter/material.dart";

import 'base_view_model.dart';



class AuthApi {
  bool isSignupApi;

  // AuthApi({@required this.isSignupApi});
  //
  // postData(data) async {
  //   return await _http.post(
  //     isSignupApi ? kSignUpApi : kSignInApi,
  //     body: jsonEncode(data),
  //     headers: _setHeaders(),
  //   );
  // }
  //
  // getData() async {
  //   return await _http.get(
  //     isSignupApi ? kSignUpApi : kSignInApi,
  //     headers: _setHeaders(),
  //   );
  // }

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
}

class AuthViewModel extends BaseViewModel {
  // String kLoginPreferenceId = "LoginPreferenceId";
  // String kProfilePreferenceId = "profileID";
  File profileImageFile;



  String signUpUserName,
      signUpEmail,
      signUpPassword,
      signUpPhone,
      signUpName,
      signInEmail,
      profileNewName,
      locationSearchListValue,
      profileResponseSharePreference,
      appointDateSelect,
      forgetEmail,
      signInPassword;
  List aboutStyleTitle= [
    "first_services",
    "second_services",
    "third_services",
    "four_services",
    "five_services"
  ];
  var aboutSelectServices;


  //int aboutDataID ;
  bool valueCheckBox = true;
  var authMsg;
  bool authError = true;
  bool isSignIn = false;
  bool isProfileIn = false;
  bool isAppointmentCancel= false;
  bool isLogout = false;
  bool isStyleList = false;
  //bool isUpcomingAppointment = false;
  bool isArtistList = false;
  bool isLocationSearchList = false;
  bool isAboutDataList = false;
  bool isShopSearchList = false;
  bool isSignUp = false;
  bool isAppointment = false;
  bool isForget = false;
  double lat;
  double lng;
  List titleList = [
    "Realism or Realistic Tattoo Style",
    "Watercolor Tattoo Style",
    "Tribal Tattoo Style",
    "New School Tattoo Style",
    "Neo Traditional Tattoo Style",
    "Japanese Tattoo Style",
    "Blackwork Tattoo Style"
  ];
  String firstServicesID="",secondServicesID="",thirdServicesID="",fourServicesID="",fiveServicesID="";
  // List<StyleList> styleList;
  // List<ArtistSearchList> artistSearchList;
  // List<ShopSearchList> shopSearchList;
  // List<LocationSearchList> locationSearchList;
  // List<AboutData> aboutDataList;
  List<int> selectedItems=[];
  int totalPrice=0;


  // GlobalKey<FormState> signInForm = GlobalKey<FormState>();
  // GlobalKey<FormState> signUpForm = GlobalKey<FormState>();
  // GlobalKey<FormState> forgetForm = GlobalKey<FormState>();

  bool validateAndSave({@required FormState formstate,}) {
    final form = formstate;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Future<void> validateAndSubmitSignIn(String deviceID,String registrationID,String typeDevice) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(ViewState.kBusy);
  //   isSignIn = false;
  //   try {
  //     //  if (validateAndSave(formstate: signInForm.currentState)) {
  //     print(
  //         "------------------Email: $signInEmail  Password: $signInPassword --------------");
  //     final response = await http.post(kSignInApi, body: {"email": signInEmail, "password": signInPassword});
  //     var body = json.decode(response.body);
  //     print("-----------------statusCode:${response.statusCode}------------------");
  //     print("-----------------$body------------------");
  //     if (response.statusCode == 200) {
  //       // print("-----------------klsfdgjld------------------");
  //       isSignIn = true;
  //       setState(ViewState.kIdle);
  //       prefs.setInt(kLoginUserId, body['response']['id']);
  //       prefs.setString(kLoginRefreshToken, body['response']['tokens']['refresh']);
  //       prefs.setString(kLoginAccessToken, body['response']['tokens']['access']);
  //       getProfile(body['response']['id']);
  //       getRegisterDevice(deviceID,registrationID,typeDevice);
  //       print("--------------------kLoginUserId:  ${prefs.getInt(kLoginUserId)}------");
  //       print("--------------------kLoginRefreshToken: ${prefs.getString(kLoginRefreshToken)}-----------");
  //       print("--------------------kLoginAccessToken:  ${prefs.getString(kLoginAccessToken)}-----------");
  //       authError = false;
  //       authMsg = "Login Successfully";
  //       // //   authMsg = body['message'];
  //     } else {
  //       authError = true;
  //       authMsg ="${body['error']}";
  //       // print("-------------------Sign  in not success ${authMsg = body['detail']}----------------");
  //     }
  //     // }
  //     print("not success");
  //     authError = false;
  //   } catch (e) {
  //     // print("-------------------Sign  in not success ${e.message.toString()}----------------");
  //     //  authMsg = "Error ${e.message.toString()}";
  //     authError = true;
  //   }
  //   setState(ViewState.kIdle);
  // }
  // Future<void> validateAndSubmitSignUp() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(ViewState.kBusy);
  //   try {
  //     // if (validateAndSave(formstate: signUpForm.currentState)) {
  //     print(
  //         "------------------Name :$signUpName Email: $signUpEmail Phone No :$signUpPhone Password : $signUpPassword Phone--------------");
  //     final response = await http.post(kSignUpApi, body: {
  //       "username": signUpName,
  //       "email": signUpEmail,
  //       "phone_number": signUpPhone,
  //       "password": signUpPassword
  //     });
  //     var body = json.decode(response.body);
  //     print("-----------------$body------------------");
  //     if (!body['error']) {
  //       print("-----------------$body------------------");
  //       setState(ViewState.kIdle);
  //       isSignUp = true;
  //       authError = false;
  //       authMsg = body['message'];
  //       /*  prefs.setString(kLoginId, json.encode(body));
  //         prefs.setBool(kIsLogin, true);*/
  //     } else {
  //       authError = true;
  //       authMsg = "${body['error']}";
  //       print(
  //           "-------------------Sign up not success ${authMsg = body['message']}----------------");
  //     }
  //     /* } else {
  //       authMsg = "Please fill all field";
  //     }*/
  //     print("not success");
  //     authError = false;
  //   } catch (e) {
  //     print(
  //         "-------------------Sign up not success ${e.message.toString()}----------------");
  //     authMsg = "Error ${e.message.toString()}";
  //     authError = true;
  //   }
  //   setState(ViewState.kIdle);
  // }
  // Future<void> validateAndSubmitForget() async {
  //   isForget = false;
  //   setState(ViewState.kBusy);
  //   try {
  //     // if (validateAndSave(formstate: signUpForm.currentState)) {
  //     print("------------------Email: $forgetEmail--------------");
  //     final response = await http.post(kForgetPasswordApi, body: {
  //       "email": forgetEmail,
  //     });
  //     var body = json.decode(response.body);
  //     print("-----------------$body------------------");
  //     if (response.statusCode ==200) {
  //       print("-----------------$body------------------");
  //       setState(ViewState.kIdle);
  //       isForget = true;
  //       authError = false;
  //       authMsg = body['message'];
  //       /*  prefs.setString(kLoginId, json.encode(body));
  //         prefs.setBool(kIsLogin, true);*/
  //     } else {
  //       authError = true;
  //       authMsg = body['message'];
  //       print("-------------------Sign up not success ${authMsg = body['message']}----------------");
  //     }
  //     /*   } else {
  //       authMsg = "Please fill all field";
  //     }*/
  //     print("not success");
  //     authError = false;
  //   } catch (e) {
  //     print(
  //         "-------------------Sign up not success ${e.message.toString()}----------------");
  //     authMsg = "Error ${e.message.toString()}";
  //     authError = true;
  //   }
  //   setState(ViewState.kIdle);
  // }
  // Future<void> getUserLogout() async {
  //   // String token="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYyMjEwMTc4MCwianRpIjoiYTk5OWNhMmQ1OTc5NDQzNTg4NTc4OTliZGIxY2RhMWEiLCJ1c2VyX2lkIjozfQ.NpdbGrcTfmVCJvNc7x_9-KJcLDbRBxRpVSzFv8pdh5Y";
  //   print("----------------------${PreferenceUtils.getString(kLoginRefreshToken)}--------------");
  //   //  print("-----------------token $token------------------");
  //
  //   setState(ViewState.kBusy);
  //   try {
  //     final response = await http
  //         .post(kLogoutApi, body: {
  //       "refresh": "${PreferenceUtils.getString(kLoginRefreshToken)}"
  //       //"refresh": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYyMjEwMzA1MCwianRpIjoiZmMyNDMxYjI3NTI1NDc4MDhmZTdlODlkZDNmZWJhZWYiLCJ1c2VyX2lkIjozfQ.i5F9uZIRbqD3Fcf6KpnlQySXefAmlj_anGRrOKC41Rg"
  //     });
  //     var body = json.decode(response.body);
  //     print("-----------------status ${response.statusCode}------------------");
  //     print("-----------------logout $body------------------");
  //     if (response.statusCode ==200) {
  //       setState(ViewState.kIdle);
  //       isLogout = true;
  //       authError = false;
  //       authMsg = "Logout Successfully";
  //     } else {
  //       authError = true;
  //       authMsg = "Logout error";
  //       print(
  //           "-------------------Sign  in not success ${authMsg = body['message']}----------------");
  //     }
  //     authError = false;
  //   } catch (e) {
  //     print("-------------------Sign  in not success ${e.message.toString()}----------------");
  //     authMsg = "Error ${e.message.toString()}";
  //     authError = true;
  //   }
  //   setState(ViewState.kIdle);
  // }
  // Future<void> getStyleList(String traditionalStyleSearchValue) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   print("-----------------$traditionalStyleSearchValue------------------");
  //   isStyleList = false;
  //   setState(ViewState.kBusy);
  //   try {
  //     final response = await http.get("https://tattooarts.herokuapp.com/traditionalsearch?search=$traditionalStyleSearchValue");
  //     var body = json.decode(response.body);
  //     //  print("-----------------$body------------------");
  //     if (body != null) {
  //       print("-----------------Response : ${response.body}------------------");
  //       styleList = styleListFromJson(response.body);
  //       print(
  //           "-----------------styleList : ${styleList.length}------------------");
  //       setState(ViewState.kIdle);
  //       isStyleList = true;
  //       authError = false;
  //       // authMsg = body['message'];
  //       //   prefs.setString(kLoginId, json.encode(body));
  //       //   prefs.setBool(kIsLogin, true);
  //     } else {
  //       authError = true;
  //       // authMsg = body['message'];
  //       print("-------------------Sign  in not success ${authMsg = body['message']}----------------");
  //     }
  //
  //     print("not success");
  //     authError = false;
  //   } catch (e) {
  //     //print("-------------------Sign  in not success ${e.message.toString()}----------------");
  //     authMsg = "Error ";
  //     // authMsg = "Error ${e.message.toString()}";
  //     authError = true;
  //   }
  //   setState(ViewState.kIdle);
  // }
  // Future<void> getArtistList(double lat,double lng,String artistSearchValue ) async {
  //   isArtistList = false;
  //   // final SharedPreferences prefs = await SharedPreferences.getInstance();\artistSearchValue
  //   print(
  //       "-----------------artistSearchValue $artistSearchValue------------------");
  //   setState(ViewState.kBusy);
  //   try {
  //     final response = await http.get("https://tattooarts.herokuapp.com/artistsearch/?search=$artistSearchValue&latitude=$lat&longitude=$lng");
  //     // final response = await http.get("https://tattooarts.herokuapp.com/artistsearch/?search=8");
  //     var body = json.decode(response.body);
  //     //  print("-----------------$body------------------");
  //     if (body != null) {
  //       print("-----------------Response : ${response.body}------------------");
  //       artistSearchList = artistSearchListFromJson(response.body);
  //       print(
  //           "-----------------styleList : ${artistSearchList.length}------------------");
  //       setState(ViewState.kIdle);
  //       isArtistList = true;
  //       authError = false;
  //       // authMsg = body['message'];
  //       //   prefs.setString(kLoginId, json.encode(body));
  //       //   prefs.setBool(kIsLogin, true);
  //       /* prefs.setString(kLoginPreferenceId, json.encode(body));
  //       loginResponseSharePreference = prefs.getString(kLoginPreferenceId);*/
  //     } else {
  //       authError = true;
  //       // authMsg = body['message'];
  //       print(
  //           "-------------------Sign  in not success ${authMsg = body['message']}----------------");
  //     }
  //
  //     print("not success");
  //     authError = false;
  //   } catch (e) {
  //     //print("-------------------Sign  in not success ${e.message.toString()}----------------");
  //     authMsg = "Error ";
  //     // authMsg = "Error ${e.message.toString()}";
  //     authError = true;
  //   }
  //   setState(ViewState.kIdle);
  // }
  // Future<void> getShopNameList(double lat,double lng,String shopSearchValue) async {
  //   isShopSearchList = false;
  //   // final SharedPreferences prefs = await SharedPreferences.getInstance();\artistSearchValue
  //   print(
  //       "-----------------artistSearchValue $shopSearchValue------------------");
  //   setState(ViewState.kBusy);
  //   try {
  //     final response = await http.get(
  //         "https://tattooarts.herokuapp.com/shopsearch/?search=$shopSearchValue&latitude=$lat&longitude=$lng");
  //     var body = json.decode(response.body);
  //     print("-----------------$body------------------");
  //     if (body != null) {
  //       print("-----------------Response : ${response.body}------------------");
  //       shopSearchList = shopSearchListFromJson(response.body);
  //       print(
  //           "-----------------styleList : ${shopSearchList.length}------------------");
  //       setState(ViewState.kIdle);
  //       isShopSearchList = true;
  //       authError = false;
  //       // authMsg = body['message'];
  //       //   prefs.setString(kLoginId, json.encode(body));
  //       //   prefs.setBool(kIsLogin, true);
  //       /* prefs.setString(kLoginPreferenceId, json.encode(body));
  //       loginResponseSharePreference = prefs.getString(kLoginPreferenceId);*/
  //     } else {
  //       authError = true;
  //       // authMsg = body['message'];
  //       print(
  //           "-------------------Sign  in not success ${authMsg = body['message']}----------------");
  //     }
  //
  //     print("not success");
  //     authError = false;
  //   } catch (e) {
  //     //print("-------------------Sign  in not success ${e.message.toString()}----------------");
  //     authMsg = "Error ";
  //     // authMsg = "Error ${e.message.toString()}";
  //     authError = true;
  //   }
  //   setState(ViewState.kIdle);
  // }
  // Future<void> getLocationSearchList() async {
  //   isLocationSearchList = false;
  //   // final SharedPreferences prefs = await SharedPreferences.getInstance();\artistSearchValue
  //   print(
  //       "-----------------locationSearchListValue $locationSearchListValue------------------");
  //   setState(ViewState.kBusy);
  //   try {
  //     final response = await http.get(
  //         "https://tattooarts.herokuapp.com/locationsearch/?search=$locationSearchListValue&latitude=$lat&longitude=$lng");
  //     var body = json.decode(response.body);
  //     //  print("-----------------$body------------------");
  //     if (body != null) {
  //       print("-----------------Response : ${response.body}------------------");
  //       locationSearchList = locationSearchListFromJson(response.body);
  //       print(
  //           "-----------------styleList : ${locationSearchList.length}------------------");
  //       setState(ViewState.kIdle);
  //       isLocationSearchList = true;
  //       authError = false;
  //       // authMsg = body['message'];
  //       //   prefs.setString(kLoginId, json.encode(body));
  //       //   prefs.setBool(kIsLogin, true);
  //       /* prefs.setString(kLoginPreferenceId, json.encode(body));
  //       loginResponseSharePreference = prefs.getString(kLoginPreferenceId);*/
  //     } else {
  //       authError = true;
  //       // authMsg = body['message'];
  //       print(
  //           "-------------------Sign  in not success ${authMsg = body['message']}----------------");
  //     }
  //
  //     print("not success");
  //     authError = false;
  //   } catch (e) {
  //     //print("-------------------Sign  in not success ${e.message.toString()}----------------");
  //     authMsg = "Error ";
  //     // authMsg = "Error ${e.message.toString()}";
  //     authError = true;
  //   }
  //   setState(ViewState.kIdle);
  // }
  // Future<void> getAboutDataList(int aboutDataID) async {
  //   isAboutDataList = false;
  //   // final SharedPreferences prefs = await SharedPreferences.getInstance();\artistSearchValue
  //   print("-----------------aboutDataID $aboutDataID------------------");
  //   setState(ViewState.kBusy);
  //   try {
  //     //final response = await http.get("https://tattooarts.herokuapp.com/Shop_artist/4");
  //     final response = await http.get("https://tattooarts.herokuapp.com/Shop_artist/$aboutDataID");
  //     // final response = await http.get("https://tattooarts.herokuapp.com/Shop_artist/1");
  //     var body = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       isAboutDataList = true;
  //       print("-----------------Response : ${response.body}------------------");
  //
  //       aboutDataList = aboutDataFromJson(response.body);
  //       print("-----------------isAboutDataList : ${aboutDataList.length}------------------");
  //       setState(ViewState.kIdle);
  //
  //       isAboutDataList = true;
  //       authError = false;
  //     }
  //
  //     authError = false;
  //   } catch (e) {
  //     //print("-------------------Sign  in not success ${e.message.toString()}----------------");
  //     authMsg = "Error ";
  //     // authMsg = "Error ${e.message.toString()}";
  //     authError = true;
  //   }
  //   setState(ViewState.kIdle);
  // }
  // Future<void> priceAdd(int price) async {
  //   totalPrice +=price;
  //   notifyListeners();
  // }
  // Future<void> priceSub(int price) async {
  //   totalPrice -=price;
  //   notifyListeners();
  // }
  // Future<void> getProfile(int id) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   // print("-----------------$traditionalStyleSearchValue------------------");
  //   //  isStyleList = false;
  //   setState(ViewState.kBusy);
  //   try {
  //     final response = await http.get("https://tattooarts.herokuapp.com/auth/get_user/$id");
  //     //final response = await http.get("https://tattooarts.herokuapp.com/auth/get_user/5");
  //     var body = json.decode(response.body);
  //     print("-----------------$body------------------");
  //     if (response.statusCode ==200) {
  //
  //
  //       // authMsg = body['message'];
  //       //   prefs.setString(kLoginId, json.encode(body));
  //       //   prefs.setBool(kIsLogin, true);
  //       prefs.setString(kProfilePreferenceId, json.encode(body));
  //
  //       print("-----------------${json.decode(profileResponseSharePreference)['username']}------------------");
  //       print("-----------------profileResponseSharePreference $profileResponseSharePreference------------------");
  //     } else {
  //       authError = true;
  //       // authMsg = body['message'];
  //       print(
  //           "-------------------Sign  in not success ${authMsg = body['message']}----------------");
  //     }
  //
  //     print("not success");
  //     authError = false;
  //   } catch (e) {
  //     //print("-------------------Sign  in not success ${e.message.toString()}----------------");
  //     authMsg = "Error ";
  //     // authMsg = "Error ${e.message.toString()}";
  //     authError = true;
  //   }
  //   setState(ViewState.kIdle);
  // }
  // Future<void> validateAndSubmitProfile(int id) async {
  //   setState(ViewState.kBusy);
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   try {
  //
  //     //  if (validateAndSave(formstate: signInForm.currentState)) {
  //
  //     print(
  //         "------------------id $id validateAndSubmitProfile: $profileNewName  ,profileImageFile :$profileImageFile--------------");
  //     final file = await http.MultipartFile.fromPath('image',profileImageFile.path );
  //     final imageUploadRequest =
  //     http.MultipartRequest('PUT', Uri.parse("https://tattooarts.herokuapp.com/auth/update_user/$id/"));
  //     imageUploadRequest.fields['username'] = "$profileNewName";
  //
  //     imageUploadRequest.files.add(file);
  //     final streamedResponse = await imageUploadRequest.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //     //  final response = await http.put(, body: {"username": profileNewName, "image":profileImageFile});
  //     print("-----------------${response.statusCode}------------------");
  //
  //     var body = json.decode(response.body);
  //     //  print("-----------------$body------------------");
  //     if (response.statusCode == 200) {
  //       isProfileIn= true;
  //       // setState(ViewState.kIdle);
  //       // prefs.setString(kLoginPreferenceId, json.encode(body));
  //       // loginResponseSharePreference = prefs.getString(kLoginPreferenceId);
  //       // authError = false;
  //       // authMsg = "Login Successfully";
  //       print("-----------------dfaskljfalldks------------------");
  //       prefs.setString(kProfilePreferenceId, json.encode(body));
  //       // //   authMsg = body['message'];
  //     } else {
  //       authError = true;
  //       //  authMsg = body['detail'];
  //       // print("-------------------Sign  in not success ${authMsg = body['detail']}----------------");
  //     }
  //     // }
  //     print("not success");
  //     authError = false;
  //   } catch (e) {
  //     // print("-------------------Sign  in not success ${e.message.toString()}----------------");
  //     //  authMsg = "Error ${e.message.toString()}";
  //     authError = true;
  //   }
  //   setState(ViewState.kIdle);
  // }
  //
  // void getSelectedServiceItem() {
  //
  //
  //
  //   for(int i=0;i<=selectedItems.length;i++){
  //     // print("----------------------${selectedItems[i]}---------------");
  //     if(selectedItems[i]== 0){
  //       print("------------first_services :${aboutDataList[0].servicesDetail[selectedItems[i]].id}-------------");
  //       firstServicesID="${aboutDataList[0].servicesDetail[selectedItems[i]].id }";
  //     }
  //
  //     else if(selectedItems[i]== 1){
  //       print("------------second_services :${aboutDataList[0].servicesDetail[selectedItems[i]].id}-------------");
  //       secondServicesID="${aboutDataList[0].servicesDetail[selectedItems[i]].id }";
  //     }
  //
  //     else if(selectedItems[i]== 2){
  //       print("------------third_services :${aboutDataList[0].servicesDetail[selectedItems[i]].id}-------------");
  //       thirdServicesID="${aboutDataList[0].servicesDetail[selectedItems[i]].id }";
  //     }
  //     else if(selectedItems[i]== 3){
  //       print("------------four_services :${aboutDataList[0].servicesDetail[selectedItems[i]].id}-------------");
  //       fourServicesID="${aboutDataList[0].servicesDetail[selectedItems[i]].id }";}
  //     else if(selectedItems[i]== 4){
  //       print("------------five_services :${aboutDataList[0].servicesDetail[selectedItems[i]].id}-------------");
  //       fiveServicesID="${aboutDataList[0].servicesDetail[selectedItems[i]].id }";
  //     }
  //   }
  //
  // }
  // Future<void> validateBookAppointment() async {
  //   isAppointment= false;
  //   setState(ViewState.kBusy);
  //   try {
  //     var headers = {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       // 'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjI1OTg4Mzg0LCJqdGkiOiI3ZjViZDFlODlhMDc0MGIyYTU2YjdjNzg0ODQzMjdmNyIsInVzZXJfaWQiOjJ9.ZFVn9RZXrihaR4aZDgpeaWJQ6oYntsz-Z1N8zfRnTZU',
  //       'Authorization': 'Bearer ${PreferenceUtils.getString(kLoginAccessToken)}',
  //     };
  //     final msg = {
  //       "appointment_date": "$appointDateSelect",
  //       "status": "request",
  //       "first_services": "$firstServicesID",
  //       "second_services": "$secondServicesID",
  //       "third_services": "$thirdServicesID",
  //       "four_services": "$fourServicesID",
  //       "five_services": "$fiveServicesID",
  //       "user": "${PreferenceUtils.getInt(kLoginUserId)}"
  //     };
  //     print("------------------appointment_date :$appointDateSelect firstServicesID: $firstServicesID secondServicesID:$secondServicesID thirdServicesID : $thirdServicesID fourServicesID $fourServicesID fiveServicesID:$fiveServicesID user:${PreferenceUtils.getInt(kLoginUserId)}-token-${PreferenceUtils.getString(kLoginAccessToken)}------------");
  //     final response = await http.post("https://tattooarts.herokuapp.com/appointment/",headers:headers,body: jsonEncode(msg));
  //     var body = json.decode(response.body);
  //     print("-----------------$body------------------");
  //     if (response.statusCode == 201) {
  //       print("-----------------$body------------------");
  //       setState(ViewState.kIdle);
  //       isAppointment = true;
  //       authError = false;
  //       authMsg = body['message'];
  //     } else {
  //       authError = true;
  //       authMsg = "${body['error']}";
  //       print("-------------------Sign up not success ${authMsg = body['message']}----------------");
  //     }
  //     /* } else {
  //       authMsg = "Please fill all field";
  //     }*/
  //     print("not success");
  //     // isAppointment= false;
  //   } catch (e) {
  //     print("-------------------Sign up not success ${e.message.toString()}----------------");
  //     // authMsg = "Error ${e.message.toString()}";
  //     authError = true;
  //   }
  //   setState(ViewState.kIdle);
  // }
  // Future<void> getAppointmentCancel(int itemId) async {
  //   print("-----------------${PreferenceUtils.getString(kLoginAccessToken)}------------------");
  //   isAppointmentCancel = false;
  //   try {
  //     var headers = {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer ${PreferenceUtils.getString(kLoginAccessToken)}',
  //     };
  //
  //     final msg = {
  //       "status": "cancel"
  //     };
  //
  //     final response = await http.patch("https://tattooarts.herokuapp.com/appointment/$itemId/",headers:headers,body: jsonEncode(msg));
  //     var body = json.decode(response.body);
  //
  //
  //     print("-----------------${response.statusCode}------------------");
  //     print("-----------------$body------------------");
  //     if (response.statusCode==200) {
  //
  //       isAppointmentCancel = true;
  //
  //
  //     } else {
  //       print(
  //           "-------------------Sign  in not success ${authMsg = body['message']}----------------");
  //       return null;
  //     }
  //
  //     print("not success");
  //
  //   } catch (e) {
  //     //print("-------------------Sign  in not success ${e.message.toString()}----------------");
  //     return null;
  //
  //     authMsg = "Error ${e.message.toString()}";
  //
  //   }
  // }
  //
  // Future<void> getRegisterDevice(String deviceID,String registrationID,String typeDevice) async {
  //   print("-----------------${PreferenceUtils.getString(kLoginAccessToken)}------------------");
  //   isAppointmentCancel = false;
  //   try {
  //     var headers = {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer ${PreferenceUtils.getString(kLoginAccessToken)}',
  //     };
  //
  //     final msg = {
  //       "device_id": "$deviceID",
  //       "registration_id": "$registrationID",
  //       "type": "$typeDevice"
  //     };
  //
  //     final response = await http.patch(kRegisterDeviceApi,headers:headers,body: jsonEncode(msg));
  //     var body = json.decode(response.body);
  //     print("-----------------$body------------------");
  //     if (response.statusCode==200) {
  //       // isAppointmentCancel = true;
  //     } else {
  //       print("-------------------Sign  in not success ${authMsg = body['message']}----------------");
  //       return null;
  //     }
  //     print("not success");
  //   } catch (e) {
  //     print("-------------------Sign  in not success ${e.message.toString()}----------------");
  //     return null;
  //
  //   }
  // }



}
