import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:barcode_scanner/views/screens/admin/dailyUpdates/widgets/lila_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyUpdate extends StatelessWidget {
  const DailyUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ValueNotifier<bool>(false);
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
                  height: 40.h,
                ),
                Text(
                  'Logistik-Scan heute',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: kBlackTextColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  'Heutiges Update hinzufügen',
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
                  height: 40.h,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 2.5),
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return LilaContainer(text: "Lilla ${index + 1}");
                  },
                ),
                SizedBox(
                  height: 103.h,
                ),
                Text(
                  'Schalten Sie den Schalter ein, wenn die Lieferung \ndringend ist',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: kBlackTextColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 11.h,
                ),
                AdvancedSwitch(
                  controller: controller,
                  activeColor: kBlueTextColor,
                  inactiveColor: kTextFieldColor,
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  width: 44.w,
                  height: 25.h,
                  enabled: true,
                  disabledOpacity: 0.5,
                ),
                SizedBox(
                  height: 73.h,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(kDataEnteringRoute);
                  },
                  child: const CustomButton(text: 'BENACHRICHTIGEN'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
