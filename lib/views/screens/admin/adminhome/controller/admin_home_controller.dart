import 'package:get/get.dart';

class AdminHomeController extends GetxController {
  RxList<Map<String, dynamic>> trucksData = RxList<Map<String, dynamic>>();

  void addTruckData(Map<String, dynamic> data) {
    trucksData.add(data);
    update();
  }

  void removeTruckData(int index) {
    if (index >= 0 && index < trucksData.length) {
      trucksData.removeAt(index);
      update();
    }
  }
}
