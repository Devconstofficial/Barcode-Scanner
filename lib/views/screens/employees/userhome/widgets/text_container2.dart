import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextContainer2 extends StatelessWidget {
  final String text;
  const TextContainer2({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154.w,
      height: 34.h,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: kGreenTextColor),
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30.w,
          ),
          Text(
            text,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: kGreenTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          const Icon(
            Icons.check,
            color: kGreenTextColor,
          )
        ],
      ),
    );
  }
}
