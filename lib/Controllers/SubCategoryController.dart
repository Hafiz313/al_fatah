import 'dart:convert';

import 'package:get/get.dart';
import 'package:inventory_app/core/datamodels/BrandModels.dart';
import 'package:inventory_app/core/datamodels/SubcategoryModel.dart';
import 'package:inventory_app/utils/app_constant.dart';
import 'package:inventory_app/utils/preference_utils.dart';

import 'login_repository.dart';


class SubCategoryController extends GetxController {
  var isLoading = false.obs;
  List<SubcategoryModels> list=[];
  @override
  void onInit() {
    fetchtfinalclasses();
    super.onInit();
  }

  void fetchtfinalclasses() async {

    try {
      list= await Repository.getSubcategoryList();
     //  var subCateGoryBody = json.decode(PreferenceUtils.getString(kShareSubCategoryList));
     //  list=  subcategoryModelsFromJson(subCateGoryBody);

      isLoading(true);
      // if (data != null) {
      //   classlist.value = data;
      // }
    } finally {
      isLoading(false);
    }
  }
}