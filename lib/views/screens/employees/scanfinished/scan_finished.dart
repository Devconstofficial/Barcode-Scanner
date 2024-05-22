import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:barcode_scanner/views/screens/employees/scanfinished/widgets/large_container.dart';
import 'package:barcode_scanner/views/screens/employees/scanfinished/widgets/small_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ScanFinished extends StatefulWidget {
  const ScanFinished({super.key});

  @override
  State<ScanFinished> createState() => _ScanFinishedState();
}

class _ScanFinishedState extends State<ScanFinished> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryBackgroundColor,
        body: Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 90.h,
                ),
                Image.asset(
                  kFinalResult,
                  width: 320.w,
                  height: 309.h,
                ),
                SizedBox(
                  height: 17.h,
                ),
                Center(
                  child: Text(
                    "18 Scans erfolgreich\nAbgeschlossen für \nLila 1 – PO1251",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: kBlackTextColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                const Center(
                    child: LargeContainer(
                        text1: 'Bauteile gescannt', text2: '18')),
                SizedBox(
                  height: 9.h,
                ),
                const Center(
                    child: LargeContainer(
                        text1: 'Zeit genommen', text2: '15 min')),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SmallContainer(
                        text1: '16',
                        text2: 'gelungener Vergleich',
                        borderColor: kGreenContainerColor,
                        textColor: kGreenTextColor),
                    SizedBox(
                      width: 5.w,
                    ),
                    const SmallContainer(
                        text1: '2',
                        text2: 'gelungener Vergleich',
                        borderColor: kRedContainerColor,
                        textColor: kRedContainerColor)
                  ],
                ),
                SizedBox(
                  height: 90.h,
                ),
                const Center(child: CustomButton(text: 'Weitermachen'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
