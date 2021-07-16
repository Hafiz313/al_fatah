import 'package:get/get.dart';
import 'package:inventory_app/core/datamodels/FyearModels.dart';

import 'login_repository.dart';


class FYearController extends GetxController {
  var isLoading = false.obs;
  List<FyearModels> fYearList=[];
  @override
  void onInit() {
    fetchtfinalclasses();
    super.onInit();
  }

  void fetchtfinalclasses() async {
    try {
      fYearList= await Repository.getFyearList();
      isLoading(true);
      print("===========locationList: ${fYearList}========$isLoading======");
    } finally {
      isLoading(false);
    }
  }
}