import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/screens/auth/controller/auth_controller.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/controller/user_home_controller.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/widgets/custom_container1.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/widgets/custom_container2.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/widgets/custom_container3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/common_code.dart';
import '../../../custom_widgets/custom_scaffold.dart';

class UserHome extends GetView<UserHomeController> {
  const UserHome({super.key});

  @override
Widget build(BuildContext context) {
  AuthController cont = Get.put(AuthController());
  return CustomScaffold(
    className: runtimeType.toString(),
    screenName: '',
    isFullBody: false,
    showAppBarBackButton: false,
    isBackIcon: false,
    appBarSize: 15,
    scaffoldKey: controller.scaffoldKeyUserHome,
    padding: EdgeInsets.only(left: 25.w, right: 25.w),
    onNotificationListener: (notificationInfo) {
      if (notificationInfo.runtimeType == UserScrollNotification) {
        CommonCode().removeTextFieldFocus();
      }
      return false;
    },
    gestureDetectorOnTap: CommonCode().removeTextFieldFocus,
    body: Obx(() {
      if (controller.isLoading.isTrue) {
        return Center(
          child: CircularProgressIndicator(color: kBlueTextColor),
        );
      } else {
        return SingleChildScrollView(
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
                        "${controller.box.read('name')}",
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
                      controller.selectedDate.value = '';
                      cont.logout();
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
              CustomContainer1(
                width: 110.w,
                date: controller.date,
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomContainer2(
                count: controller.truckList.length,
                lilaCount: controller.lilaCount,
                containerCount: controller.containerCount,
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
                itemCount: controller.truckList.length,
                itemBuilder: (context, index) {
                  return CustomCOntainer3(
                  
                    text: controller.truckList[index].truckName,
                    containers: controller.truckList[index].containers,
                  );
                },
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        );
      }
    }),
  );
}
}