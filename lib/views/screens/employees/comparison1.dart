import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_appbar.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Comparison1 extends StatelessWidget {
  const Comparison1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: kPrimaryBackgroundColor,
            body: Padding(
                padding: EdgeInsets.only(left: 25, right: 25.w),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      const CustomAppBar(
                        showText: false,
                      ),
                      SizedBox(
                        height: 207.h,
                      ),
                      Image.asset(kApprove),
                      SizedBox(
                        height: 42.h,
                      ),
                      Text(
                        'Vergleich erfolgreich',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: kBlackTextColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 42.h,
                      ),
                      Text(
                        'Barcode 1 und Barcode 2 sind gleich',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: kBlackTextColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 173.h,
                      ),
                      InkWell(
                          onTap: () {
                            Get.toNamed(kComparison2Route);
                          },
                          child: const CustomButton(text: 'Weitermachen'))
                    ])))));
  }
}
