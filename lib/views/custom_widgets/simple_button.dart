import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 372.w,
      height: 59.h,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: kBlueTextColor),
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
      child: Center(
        child: Text(
          "Wiederholen Sie den Scan",
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              color: kBlueTextColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}
