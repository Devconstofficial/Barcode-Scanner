import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:barcode_scanner/views/screens/admin/adminhome/controller/admin_home_controller.dart';

class DataEnteringController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RxList<Map<String, dynamic>> dataList = RxList<Map<String, dynamic>>();
  RxBool addContainer = false.obs;
  TextEditingController lilaNumber = TextEditingController();
  TextEditingController lilaQuantity = TextEditingController();
  RxString lilaText = ''.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    lilaText.value = Get.arguments ?? "Lila";
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final String adminId = user.uid;
    final DateTime today = DateTime.now();
    final String todayString = DateFormat('yyyy-MM-dd').format(today);

    QuerySnapshot query = await _firestore
        .collection('trucks')
        .where('adminId', isEqualTo: adminId)
        .where('truckName', isEqualTo: lilaText.value)
        .get();

    if (query.docs.isNotEmpty) {
      for (var doc in query.docs) {
        List<dynamic> containers = doc['containers'];
        for (var container in containers) {
          if (DateFormat('yyyy-MM-dd').format(container['date'].toDate()) == todayString) {
            Map<String, dynamic> localData = {
              "lilaText": lilaText.value,
              "lilaNumber": container['containerId'],
              "lilaQuantity": container['quantity'],
            };
            dataList.add(localData);
          }
        }
      }
    }
  }

  Future<void> addDataToList(String lilaText) async {
    String number = lilaNumber.text.trim();
    int quantity = int.tryParse(lilaQuantity.text.trim()) ?? 0;

    if (number.isNotEmpty && quantity > 0) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      DateTime dateTime = DateTime.now();
      String date = '${dateTime.day}/${dateTime.month}/${dateTime.year}';

      final String adminId = user.uid;
      QuerySnapshot query = await _firestore
          .collection('trucks')
          .where('adminId', isEqualTo: adminId)
          .where('truckName', isEqualTo: lilaText)
          .get();

      if (query.docs.isNotEmpty) {
        DocumentSnapshot doc = query.docs.first;
        List<dynamic> containers = doc['containers'];
        containers.add({
          'adminId': adminId,
          'containerId': number,
          'quantity': quantity,
          'date': date,
          'time': '',
          'count': quantity,
          'scanFailed': 0,
          'scanSuccess': 0,
          'isCheck': false,
        });

        int totalCount = containers.fold(0, (sum, container) => sum + (container['quantity'] as int));
        await _firestore.collection('trucks').doc(doc.id).update({
          'containers': containers,
          'totalCount': totalCount,
        });
      } else {
        await _firestore.collection('trucks').add({
          'adminId': adminId,
          'truckName': lilaText,
          'containers': [
            {
              'adminId': adminId,
              'containerId': number,
              'quantity': quantity,
              'date': date,
          'time': '',
          'count': quantity,
              'scanFailed': 0,
              'scanSuccess': 0,
              'isCheck': false,
            },
          ],
          'totalCount': quantity,
          'totalSuccess': 0,
          'totalFail': 0,
        });
      }

      Map<String, dynamic> localData = {
        "lilaText": lilaText,
        "lilaNumber": number,
        "lilaQuantity": quantity,
      };
      dataList.add(localData);

      final adminHomeController = Get.find<AdminHomeController>();
      adminHomeController.addTruckData(localData);

      addContainer.value = false;
      lilaNumber.clear();
      lilaQuantity.clear();
    }
  }

  void deleteItem(int index) async {
  if (index < 0 || index >= dataList.length) return;

  final item = dataList[index];
  String lilaNumber = item['lilaNumber'];
  String lilaText = item['lilaText'];

  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final String adminId = user.uid;
  QuerySnapshot query = await _firestore
      .collection('trucks')
      .where('adminId', isEqualTo: adminId)
      .where('truckName', isEqualTo: lilaText)
      .get();

  if (query.docs.isNotEmpty) {
    DocumentSnapshot doc = query.docs.first;
    List<dynamic> containers = List.from(doc['containers']);

    containers.removeWhere((container) => container['containerId'] == lilaNumber);

    if (containers.isEmpty) {
      await _firestore.collection('trucks').doc(doc.id).delete();
    } else {
      int totalCount = containers.fold(0, (sum, container) => sum + (container['quantity'] as int));
      await _firestore.collection('trucks').doc(doc.id).update({
        'containers': containers,
        'totalCount': totalCount,
      });
    }
  }
  dataList.removeAt(index);
  update();
  final adminHomeController = Get.find<AdminHomeController>();
  adminHomeController.removeTruckData(item);
}

}
