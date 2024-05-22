import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:barcode_scanner/views/screens/admin/adminhome/widgets/admin_text_container1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminCustomContainer3 extends StatelessWidget {
  final Map<String, dynamic> truckData;
  final String text;

  const AdminCustomContainer3(
      {super.key, required this.truckData, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 184.w,
      height: 251.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        shadows: [
          BoxShadow(
            color: kBoxShadowColor,
            blurRadius: 4.r,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h, left: 18.w),
            child: Row(
              children: [
                SizedBox(
                  width: 28.w,
                  height: 28.h,
                  child: Image.asset(kTruck),
                ),
                SizedBox(
                  width: 17.w,
                ),
                Text(
                  text,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: kBlackTextColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 14.h, bottom: 9.h),
            child: AdminTextContainer1(
              text: '[${truckData["lilaQuantity"]}] ${truckData["lilaNumber"]}',
              width: 30.w,
            ),
          ),
          AdminTextContainer1(
            text: '[${truckData["lilaQuantity"]}] ${truckData["lilaNumber"]}',
            width: 30.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 14.h, bottom: 9.h),
            child: AdminTextContainer1(
              text: '[${truckData["lilaQuantity"]}] ${truckData["lilaNumber"]}',
              width: 30.w,
            ),
          ),
          AdminTextContainer1(
            text: '[${truckData["lilaQuantity"]}] ${truckData["lilaNumber"]}',
            width: 30.w,
          ),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
    );
  }
}

class Truck {
  final String id;
  final int container1Quantity;
  final int container2Quantity;
  final int container3Quantity;
  final int container4Quantity;
  final String container1Number;
  final String container2Number;
  final String container3Number;
  final String container4Number;

  Truck({
    required this.id,
    required this.container1Quantity,
    required this.container2Quantity,
    required this.container3Quantity,
    required this.container4Quantity,
    required this.container1Number,
    required this.container2Number,
    required this.container3Number,
    required this.container4Number,
  });

  // Define fromJson and toJson if needed
}
