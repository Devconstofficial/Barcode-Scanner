import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallContainer extends StatelessWidget {
  final String text1;
  final String text2;
  final Color borderColor;
  final Color textColor;
  const SmallContainer({
    super.key,
    required this.text1,
    required this.text2,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165.w,
      height: 54.h,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: borderColor),
          borderRadius: BorderRadius.circular(50.r),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text1,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          Text(
            text2,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: kGreyTextColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
