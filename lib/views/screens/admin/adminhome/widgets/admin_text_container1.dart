import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminTextContainer1 extends StatelessWidget {
  final String text;
  final bool showIcon; 
  final double width;

  const AdminTextContainer1({super.key, required this.text, this.showIcon = true, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154.w,
      height: 34.h,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: kBlueTextColor),
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: width,
          ),
          Text(
            text,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: showIcon? kGreenContainerColor : kBlueTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
          Icon(
              showIcon ? Icons.check : Icons.arrow_forward_outlined,
              color: showIcon ? Colors.green : kBlueTextColor,
            )
        ],
      ),
    );
  }
}
