import 'package:barcode_scanner/views/screens/admin/adminhome/controller/admin_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataEnteringController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RxList<Map<String, dynamic>> dataList = RxList<Map<String, dynamic>>();
  RxBool addContainer = false.obs;
  RxBool addComponent = false.obs;
  RxBool showComponent = false.obs;
  TextEditingController lilaNumber = TextEditingController(),
      lilaQuantity = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Load data from AdminHomeController
    final adminHomeController = Get.find<AdminHomeController>();
    dataList.assignAll(adminHomeController.trucksData);
  }

  void addDataToList() {
    String number = lilaNumber.text;
    int quantity = int.tryParse(lilaQuantity.text) ?? 0;
    if (number.isNotEmpty) {
      Map<String, dynamic> data = {
        "lilaNumber": number,
        "lilaQuantity": quantity,
      };
      dataList.add(data);

      // Save data to shared state
      final adminHomeController = Get.find<AdminHomeController>();
      adminHomeController.addTruckData(data);

      addComponent.value = true;
    }

    lilaNumber.clear();
    lilaQuantity.clear();
  }

  void deleteItem(int index) {
    if (index >= 0 && index < dataList.length) {
      dataList.removeAt(index);

      // Remove data from shared state
      final adminHomeController = Get.find<AdminHomeController>();
      adminHomeController.removeTruckData(index);
    }
  }
}
