import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/widgets/text_container1.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/widgets/text_container2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCOntainer3 extends StatelessWidget {
  final String text;
  const CustomCOntainer3({Key? key, required this.text});

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
            child: TextContainer1(
              text: '[18] PO1251',
              width: 30.w,
            ),
          ),
          const TextContainer2(
            text: '[10] PO1356',
          ),
          Padding(
            padding: EdgeInsets.only(top: 14.h, bottom: 9.h),
            child: TextContainer1(
              text: '[15] PO1386',
              width: 30.w,
            ),
          ),
          TextContainer1(
            text: '[20] PO1740',
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
