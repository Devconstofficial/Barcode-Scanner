import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/screens/admin/adminhome/controller/admin_home_controller.dart';
import 'package:barcode_scanner/views/screens/admin/adminhome/widgets/admin_custom_container1.dart';
import 'package:barcode_scanner/views/screens/admin/adminhome/widgets/admin_custom_container2.dart';
import 'package:barcode_scanner/views/screens/admin/adminhome/widgets/admin_custom_container3.dart';
import 'package:barcode_scanner/views/screens/auth/controller/auth_controller.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/widgets/custom_container3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    AdminHomeController controller1 =
        Get.put(AdminHomeController(), permanent: true);
    AuthController controller = Get.put(AuthController());

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
                  height: 30.h,
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
                          '${controller1.box.read('name')}',
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
                        controller1.selectedDate.value = '';
                        controller.logout();
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: kBlueTextColor,
                          ),
                          Text(
                            "Abmelden",
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
                  date: controller1.date,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Obx(() {
                  if (controller1.isLoading.isTrue) {
                    return Center(
                      child: CircularProgressIndicator(color: kBlueTextColor),
                    );
                  } else {
                    return Column(
                      children: [
                       
                       AdminCustomContainer2(
                count: controller1.truckList.length,
                lilaCount: controller1.lilaCount,
                containerCount: controller1.containerCount,
              ),
              SizedBox(
                height: 8.h,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.65),
                ),
                itemCount: controller1.truckList.length,
                itemBuilder: (context, index) {
                  return AdminCustomContainer3(
                    text: controller1.truckList[index].truckName,
                    containers: controller1.truckList[index].containers,
                  );
                },
              ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
