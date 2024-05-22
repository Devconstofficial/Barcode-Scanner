import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LilaContainer extends StatefulWidget {
  final String text;
  const LilaContainer({super.key, required this.text});

  @override
  // ignore: library_private_types_in_public_api
  _LilaContainerState createState() => _LilaContainerState();
}

class _LilaContainerState extends State<LilaContainer> {
  bool isImageVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isImageVisible = !isImageVisible;
        });
        Get.toNamed('/dataEntering', arguments: widget.text);
      },
      child: Container(
        width: 184.w,
        height: 158.h,
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
        child: Row(
          children: [
            SizedBox(
              width: 35.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  kTruck2,
                  height: 80.h,
                  width: 80.w,
                ),
                Text(
                  widget.text,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: kBlackTextColor,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
            if (isImageVisible)
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Image.asset(
                      kApprove1,
                      height: 29.h,
                      width: 29.w,
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
