import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_appbar.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:barcode_scanner/views/screens/employees/comparison1.dart';
import 'package:barcode_scanner/views/screens/employees/comparison2.dart';
import 'package:barcode_scanner/views/screens/employees/container_details/controller/container_detail_controller.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/widgets/text_container1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/common_code.dart';
import '../../../custom_widgets/custom_scaffold.dart';
import '../../../../../models/truck_model.dart' as model;

class ContainerDetails extends GetView<ContainerDetailController> {
  const ContainerDetails({Key? key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String truckName = arguments['truckName'];
    final int quantity = arguments['quantity'];
    final String containerId = arguments['containerId'];
    final model.Container container = arguments['container'];

    return WillPopScope(
      onWillPop: () async {
        if (controller.containerCount.value != 0) {
          Get.snackbar(
              backgroundColor: kBlackTextColor,
              colorText: kWhiteTextColor,
              'Fehler!!',
              "Bitte beenden Sie das Scannen, bevor Sie gehen!");
          return false;
        }
        return true;
      },
      child: CustomScaffold(
        className: runtimeType.toString(),
        screenName: '',
        isFullBody: true,
        showAppBarBackButton: true,
        isBackIcon: true,
        scaffoldKey: controller.scaffoldKeyContainerDetail,
        onNotificationListener: (notificationInfo) {
          if (notificationInfo.runtimeType == UserScrollNotification) {
            CommonCode().removeTextFieldFocus();
          }
          return false;
        },
        gestureDetectorOnTap: CommonCode().removeTextFieldFocus,
        body: Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomAppBar(
                  showText: false,
                ),
                SizedBox(height: 110.h),
                Image.asset(
                  kTruck2,
                  width: 118.w,
                  height: 118.h,
                ),
                SizedBox(height: 18.h),
                InkWell(
                  onTap: () {
                    Get.toNamed(kComparison1Route);
                  },
                  child: Text(
                    truckName,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: kBlackTextColor,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 28.h),
                Container(
                  width: 154.w,
                  height: 34.h,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.w, color: kBlueTextColor),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      containerId,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: kBlueTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 28.h),
                Obx(() => Text(
                      '${controller.containerCount.value}',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: kBlackTextColor,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    )),
                SizedBox(height: 11.h),
                Text(
                  "Bauteile",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: kBlackTextColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(height: 110.h),
                InkWell(
                  onTap: () async {
                    if (controller.containerCount.value == quantity) {
                      controller.startTimer();
                    }
                    var res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SimpleBarcodeScannerPage(),
                      ),
                    );
                    if (res is String) {
                      controller.result1.value = res;
                      // Display dialog box here
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Barcode 1 erfolgreich!!'),
                          content: Text('Weitermachen zu Barcode 2'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); 
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const CustomButton(text: 'Scan Starten'),
                ),
                Obx(() =>
                    Text('Barcode-Ergebnis 1: ${controller.result1.value}')),
                InkWell(
                  onTap: () async {
                    var res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SimpleBarcodeScannerPage(),
                      ),
                    );
                    if (res is String) {
                      controller.result2.value = res;

                      if (controller.result1.value ==
                          controller.result2.value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Comparison1(),
                            settings: RouteSettings(arguments: {
                              'truckName': truckName,
                              'quantity': quantity,
                              'containerId': containerId,
                              'container': container,
                            }),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Comparison2(),
                            settings: RouteSettings(arguments: {
                              'truckName': truckName,
                              'quantity': quantity,
                              'containerId': containerId,
                              'container': container,
                            }),
                          ),
                        );
                      }
                    }
                  },
                  child: const CustomButton(text: 'Scan Starten'),
                ),
                Obx(() =>
                    Text('Barcode-Ergebnis 2: ${controller.result2.value}')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
