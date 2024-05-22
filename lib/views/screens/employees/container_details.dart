import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_appbar.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:barcode_scanner/views/screens/employees/comparison1.dart';
import 'package:barcode_scanner/views/screens/employees/comparison2.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/widgets/text_container1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';

class ContainerDetails extends StatefulWidget {
  const ContainerDetails({super.key});

  @override
  State<ContainerDetails> createState() => _ContainerDetailsState();
}

class _ContainerDetailsState extends State<ContainerDetails> {
  String result1 = '';
  String result2 = '';

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
                SizedBox(height: 110.h),
                Image.asset(
                  kTruck2,
                  width: 118.w,
                  height: 118.h,
                ),
                SizedBox(height: 18.h),
                InkWell(
                  onTap: () {
                    Get.toNamed(kComparison1Route);
                  },
                  child: Text(
                    "Lila 1",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: kBlackTextColor,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 28.h),
                TextContainer1(
                  text: 'PO125',
                  showIcon: false,
                  width: 55.w,
                ),
                SizedBox(height: 28.h),
                Text(
                  "18",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: kBlackTextColor,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(height: 11.h),
                Text(
                  "Bauteile",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: kBlackTextColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(height: 110.h),
                InkWell(
                  onTap: () async {
                    var res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SimpleBarcodeScannerPage(),
                      ),
                    );
                    setState(() {
                      if (res is String) {
                        result1 = res;

                        if (result1 == result2) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Comparison1()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Comparison2()));
                        }
                      }
                    });
                  },
                  child: const CustomButton(text: 'Scan Starten'),
                ),
                Text('Barcode Result 1: $result1'),
                InkWell(
                  onTap: () async {
                    var res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SimpleBarcodeScannerPage(),
                      ),
                    );
                    setState(() {
                      if (res is String) {
                        result2 = res;

                        if (result1 == result2) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Comparison1()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Comparison2()));
                        }
                      }
                    });
                  },
                  child: const CustomButton(text: 'Scan Starten'),
                ),
                Text('Barcode Result 2: $result2'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
