import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_appbar.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:barcode_scanner/views/custom_widgets/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Comparison2 extends StatefulWidget {
  const Comparison2({super.key});

  @override
  State<Comparison2> createState() => _Comparison2State();
}

class _Comparison2State extends State<Comparison2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: kPrimaryBackgroundColor,
            body: Padding(
                padding: EdgeInsets.only(left: 25.w, right: 25.w),
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
                      Image.asset(kRejected),
                      SizedBox(
                        height: 42.h,
                      ),
                      Text(
                        'Vergleich erfolglos',
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
                        height: 233.h,
                      ),
                      const SimpleButton(),
                      SizedBox(
                        height: 22.h,
                      ),
                      InkWell(
                          onTap: () {
                            Get.toNamed(kScanFinishedRoute);
                          },
                          child: const CustomButton(text: 'Weitermachen'))
                    ])))));
  }
}
