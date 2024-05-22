import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LargeContainer extends StatelessWidget {
  final String text1;
  final String text2;
  const LargeContainer({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 332.w,
      height: 54.h,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: kTextFieldColor),
          borderRadius: BorderRadius.circular(50.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text1,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: kGreyTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          SizedBox(
            width: 60.w,
          ),
          Text(
            text2,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: kBlueTextColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
