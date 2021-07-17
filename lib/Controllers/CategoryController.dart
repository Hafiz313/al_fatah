import 'dart:convert';

import 'package:get/get.dart';
import 'package:inventory_app/core/datamodels/CategoryModels.dart';
import 'package:inventory_app/utils/app_constant.dart';
import 'package:inventory_app/utils/preference_utils.dart';

import 'login_repository.dart';


class CategoryController extends GetxController {
  var isLoading = false.obs;
  List<CategoryModels> categoryList=[];
  @override
  void onInit() {
    fetchtfinalclasses();
    super.onInit();
  }

  void fetchtfinalclasses() async {

    try {
      categoryList= await Repository.getCategoryList();
      // var cateGoryBody = json.decode(PreferenceUtils.getString(kShareCateGoryList));
      // categoryList=  categoryModelsFromJson(cateGoryBody);
      // print("==========cateGoryBody======${categoryList.length}=============");
      isLoading(true);
      print("===========categoryList: ${categoryList}========$isLoading======");
      // if (data != null) {
      //   classlist.value = data;
      // }
    } finally {
      isLoading(false);
    }
  }
}