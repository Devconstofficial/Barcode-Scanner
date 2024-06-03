import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting

import '../../../../../models/truck_model.dart';

class UserHomeController extends GetxController {
  flutter.GlobalKey<flutter.ScaffoldState> scaffoldKeyUserHome =
      flutter.GlobalKey<flutter.ScaffoldState>();
  RxString date = ''.obs;
  RxString selectedDate = ''.obs;
  RxInt lilaCount = 0.obs;
  RxInt containerCount = 0.obs;
  final box = GetStorage();
  RxList<Truck> truckList = <Truck>[].obs;
  RxBool isLoading = true.obs;
  

  @override
  void onInit() {
    super.onInit();
    fetchTrucks();
    ever(selectedDate, (_) => fetchTrucks());
    Future.delayed(Duration(seconds: 10), () {
      isLoading.value = false;
    });
  }

  Future<void> fetchTrucks() async {
  try {
    isLoading.value = true;
    print('Fetching trucks...');
    print('Selected Date: ${selectedDate.value}');

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('trucks').get();

    final List<Truck> trucksData = querySnapshot.docs.map((doc) {
      return Truck.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    Map<String, List<Container>> groupedContainers = {};
    int totalContainers = 0;
    int totalQuantities = 0;

    for (var truck in trucksData) {
      List<Container> filteredContainers;

      if (selectedDate.value.isEmpty) {
        filteredContainers = truck.containers;  // No date filtering, include all containers
      } else {
        filteredContainers = truck.containers.where((container) {
          print('Comparing Container Date: ${container.date} with Selected Date: ${selectedDate.value}');
          return container.date == selectedDate.value;
        }).toList();
      }

      if (filteredContainers.isNotEmpty) {
        totalContainers += filteredContainers.length;
        for (var container in filteredContainers) {
          totalQuantities += container.quantity;
          if (!groupedContainers.containsKey(truck.truckName)) {
            groupedContainers[truck.truckName] = [];
          }
          groupedContainers[truck.truckName]!.add(container);
        }
      }
    }

    lilaCount.value = totalContainers;
    containerCount.value = totalQuantities;
    truckList.value = groupedContainers.entries.map((entry) {
      return Truck(
        adminId: trucksData
            .firstWhere((truck) => truck.truckName == entry.key)
            .adminId,
        truckName: entry.key,
        containers: entry.value,
        totalCount: entry.value.length,
        totalSuccess: entry.value
            .where((container) => container.scanSuccess > 0)
            .length,
        totalFail:
            entry.value.where((container) => container.scanFailed > 0).length,
      );
    }).toList();
    truckList.sort((a, b) => a.truckName.compareTo(b.truckName));
    isLoading.value = false;
    print('Truck List: $truckList');
    print('Total Containers: $totalContainers');
    print('Total Quantities: $totalQuantities');
  } catch (error) {
    isLoading.value = false;
    print('Error fetching trucks: $error');
  }
}


}

