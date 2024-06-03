import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:barcode_scanner/views/screens/employees/scanfinished/controller/scan_finished_controller.dart';
import 'package:barcode_scanner/views/screens/employees/scanfinished/widgets/large_container.dart';
import 'package:barcode_scanner/views/screens/employees/scanfinished/widgets/small_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/common_code.dart';
import '../../../custom_widgets/custom_scaffold.dart';
import '../../../../../models/truck_model.dart' as model;

class ScanFinished extends GetView<ScanFinishedController>{
  const ScanFinished({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String truckName = arguments['truckName'];
    final int quantity = arguments['quantity'];
    final String containerId = arguments['containerId'];
    final model.Container container = arguments['container'];
   return CustomScaffold(
      className: runtimeType.toString(), 
      screenName: '', 
      isFullBody: true,
      showAppBarBackButton: true,
      isBackIcon: true,
      scaffoldKey: controller.scaffoldKeyScanFinished,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 90.h,
                ),
                Image.asset(
                  kFinalResult,
                  width: 320.w,
                  height: 309.h,
                ),
                SizedBox(
                  height: 17.h,
                ),
                Center(
                  child: Text(
                    "${quantity} Scans erfolgreich\nAbgeschlossen für \nLila 1 – $containerId",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: kBlackTextColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                 Center(
                    child: LargeContainer(
                        text1: 'Bauteile gescannt', text2: "${container.quantity}")),
                
                SizedBox(
                  height: 10.h,
                ),
                Center(
                    child: LargeContainer(
                        text1: 'Gesamte Scanzeit', text2: "${container.time}")),
                
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallContainer(
                        text1: "${container.scanSuccess}",
                        text2: 'erfolgreiche Vergleiche',
                        borderColor: kGreenContainerColor,
                        textColor: kGreenTextColor),
                    SizedBox(
                      width: 5.w,
                    ),
                    SmallContainer(
                        text1: '${container.scanFailed}',
                        text2: 'fehlgeschlagene Vergleiche',
                        borderColor: kRedContainerColor,
                        textColor: kRedContainerColor)
                  ],
                ),
                SizedBox(
                  height: 90.h,
                ),
                Center(child: CustomButton(
                  onPressed: (){
                    Get.back();
                  },
                  text: 'Weitermachen'))
              ],
            ),
          ),
        ),
      );

  }
}
