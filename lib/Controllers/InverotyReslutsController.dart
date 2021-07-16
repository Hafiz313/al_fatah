import 'package:get/get.dart';
import 'package:inventory_app/core/datamodels/InventoryResultModel.dart';

import 'login_repository.dart';


class InventoryResultsController extends GetxController {

  String brandCode, categoryCode, subCategoryCode,itemText;

  InventoryResultsController(
      this.brandCode, this.categoryCode, this.subCategoryCode,this.itemText);

  var isLoading = false.obs;
  List<InventoryResultModel> inventoryResultsList=[];

  @override
  void onInit() {
    fetchtfinalclasses();
    super.onInit();
  }

  void fetchtfinalclasses() async {

    try {
      inventoryResultsList= await Repository.getInventoryResluts(brandCode,categoryCode,subCategoryCode,itemText);
      isLoading(true);
      print("===========brandCode:$brandCode==categoryCode:$categoryCode===subCategoryCode:$subCategoryCode===itemText:$itemText======$isLoading======");
      // if (data != null) {
      //   classlist.value = data;
      // }
    } finally {
      isLoading(false);
    }
  }
}