import 'dart:convert';

import 'package:get/get.dart';
import 'package:inventory_app/core/datamodels/BrandModels.dart';
import 'package:inventory_app/utils/app_constant.dart';
import 'package:inventory_app/utils/preference_utils.dart';

import 'login_repository.dart';


class BrandController extends GetxController {
  var isLoading = false.obs;
  List<BrandModels> brandList=[];
  @override
  void onInit() {
    fetchtfinalclasses();
    super.onInit();
  }

  void fetchtfinalclasses() async {

    try {
      var body = json.decode(PreferenceUtils.getString(kShareBrandList));
      print("====brandModelsFromJson=body:$body=======");
      brandList=  brandModelsFromJson(body);
   //  brandList= await Repository.getBrandList();
      isLoading(true);
      // if (data != null) {
      //   classlist.value = data;
      // }
    } finally {
      isLoading(false);
    }
  }
}