import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ContainerDetailController extends GetxController {
  var scaffoldKeyContainerDetail = GlobalKey<ScaffoldState>();
  RxString result1 = ''.obs;
  RxString result2 = ''.obs;

  RxInt containerCount = 0.obs;
  RxString timerValue = ''.obs; // Define RxString variable for timer value

  Timer? timer; // Declare timer variable

  @override
  void onInit() {
    super.onInit();
    containerCount.value = Get.arguments['container'].count;
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    int secondsPassed = 0;
    timer = Timer.periodic(oneSecond, (timer) {
      secondsPassed++;
      timerValue.value = '${secondsPassed}s';
      if (containerCount.value == 0) {
        timer.cancel(); 
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }
}
