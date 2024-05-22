import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/screens/admin/adminhome/controller/admin_home_controller.dart';
import 'package:barcode_scanner/views/screens/admin/adminhome/widgets/admin_custom_container1.dart';
import 'package:barcode_scanner/views/screens/admin/adminhome/widgets/admin_custom_container2.dart';
import 'package:barcode_scanner/views/screens/admin/adminhome/widgets/admin_custom_container3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminHomeController());

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
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Guten Tag!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              color: kBlackTextColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                        Text(
                          "Mustafa",
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
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Get.off(kUserSigninRoute);
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: kBlueTextColor,
                          ),
                          Text(
                            "Logout",
                            style: TextStyle(color: kBlueTextColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                AdminCustomContainer1(
                  width: 110.w,
                ),
                SizedBox(
                  height: 8.h,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(kContainerDetailsRoute);
                  },
                  child: GetBuilder<AdminHomeController>(
                    builder: (controller) {
                      int totalParts = controller.trucksData.fold(
                        0,
                        (previousValue, truck) =>
                            previousValue + (truck["lilaQuantity"] ?? 0) as int,
                      );

                      return AdminCustomContainer2(
                        count: controller.trucksData.length,
                        totalParts: totalParts,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                GetBuilder<AdminHomeController>(
                  builder: (controller) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.65),
                      ),
                      itemCount: controller.trucksData.length,
                      itemBuilder: (context, index) {
                        final truckData = controller.trucksData[index];
                        int val = index + 1;
                        return AdminCustomContainer3(
                            truckData: truckData, text: "Lila $val");
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
