import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/widgets/text_container1.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/widgets/text_container2.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../models/truck_model.dart' as model;
import '../../../../../utils/app_strings.dart';

class CustomCOntainer3 extends flutter.StatelessWidget {
  final String text;
  final List<model.Container> containers;

  const CustomCOntainer3(
      {flutter.Key? key, required this.text, required this.containers})
      : super(key: key);

  @override
  flutter.Widget build(flutter.BuildContext context) {
    return flutter.Container(
      width: 184.w,
      height: 251.h,
      decoration: flutter.ShapeDecoration(
        color: flutter.Colors.white,
        shape: flutter.RoundedRectangleBorder(
          borderRadius: flutter.BorderRadius.circular(10.r),
        ),
        shadows: [
          flutter.BoxShadow(
            color: kBoxShadowColor,
            blurRadius: 4.r,
            offset: const flutter.Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: flutter.Column(
        mainAxisSize: flutter.MainAxisSize.min,
        children: [
          flutter.Padding(
            padding: flutter.EdgeInsets.only(top: 20.h, left: 18.w),
            child: flutter.Row(
              children: [
                flutter.SizedBox(
                  width: 28.w,
                  height: 28.h,
                  child: flutter.Image.asset(kTruck),
                ),
                flutter.SizedBox(
                  width: 17.w,
                ),
                flutter.Text(
                  text,
                  style: GoogleFonts.montserrat(
                    textStyle: flutter.TextStyle(
                      color: kBlackTextColor,
                      fontSize: 16.sp,
                      fontWeight: flutter.FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          flutter.Expanded(
            child: flutter.SingleChildScrollView(
              child: flutter.Column(
                children: containers.map((container) {
                  return flutter.Padding(
                    padding: flutter.EdgeInsets.only(top: 10.h),
                    child: flutter.GestureDetector(
                      onTap: () {
                        if(container.isCheck){
                          Get.toNamed(kScanFinishedRoute, arguments: {'truckName': text, 'quantity': container.quantity, 'containerId': container.containerId, 'container': container});
                        } else {
                          Get.toNamed(kContainerDetailsRoute, arguments: {'truckName': text, 'quantity': container.quantity, 'containerId': container.containerId, 'container': container});
                        }
                      },
                      child: TextContainer1(
                        text:
                            '[${container.quantity}] ${container.containerId}',
                        showIcon: true,
                        width: 30.w,
                        isCheck: container.isCheck,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          flutter.SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}
