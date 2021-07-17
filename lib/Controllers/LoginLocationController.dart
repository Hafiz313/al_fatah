import 'package:get/get.dart';

import '../core/datamodels/LocationModels.dart';
import 'login_repository.dart';


class LocationController extends GetxController {
  var isLoading = false.obs;
  List<LocationModels> locationList=[];
  @override
  void onInit() {
    fetchtfinalclasses();
    super.onInit();
  }

  void fetchtfinalclasses() async {

    try {
      locationList= await Repository.getLocationList();
      isLoading(true);
    } finally {
      isLoading(false);
    }
  }
}