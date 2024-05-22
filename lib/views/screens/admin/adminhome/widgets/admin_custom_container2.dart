import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class AdminCustomContainer2 extends StatelessWidget {
  int count;
  int totalParts;

  AdminCustomContainer2({
    super.key,
    required this.count,
    required this.totalParts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 376.w,
      height: 160.h,
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
      child: Padding(
        padding: EdgeInsets.only(top: 8.h, left: 11.w),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Heute',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: kBlackTextColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 18.w,
                ),
                Image.asset(kTruck),
                SizedBox(
                  width: 21.w,
                ),
                Column(
                  children: [
                    Text(
                      '$count',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: kBlueTextColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                    Text(
                      'LKW/ Lila',
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
                SizedBox(
                  width: 50.w,
                ),
                SvgPicture.asset(
                  kOrder,
                ),
                SizedBox(
                  width: 18.w,
                ),
                Column(
                  children: [
                    Text(
                      '$totalParts',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: kBlueTextColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                    Text(
                      'Behälter',
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
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 35.w,
                ),
                Container(
                  width: 4.w,
                  height: 25.h,
                  decoration: const BoxDecoration(color: kBlueTextColor),
                ),
                SizedBox(
                  width: 29.w,
                ),
                Text(
                  "$totalParts gesamte Bauteile",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: kBlueTextColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
