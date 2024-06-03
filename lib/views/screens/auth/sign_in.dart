import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_scaffold.dart';
import 'package:barcode_scanner/views/custom_widgets/password_textfield.dart';
import 'package:barcode_scanner/views/custom_widgets/simpletext_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/common_code.dart';
import 'controller/auth_controller.dart';


class Signin extends GetView<AuthController> {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      className: runtimeType.toString(), 
      screenName: '', 
      isFullBody: true,
      showAppBarBackButton: false,
      isBackIcon: false,
      scaffoldKey: controller.scaffoldKeyLogin,
      onNotificationListener: (notificationInfo) {
        if (notificationInfo.runtimeType == UserScrollNotification) {
          CommonCode().removeTextFieldFocus();
        }
        return false;
      },
      gestureDetectorOnTap: CommonCode().removeTextFieldFocus, 
      body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 29.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 170.h),
            Center(child: Image.asset(kLogo)),
            SizedBox(height: 70.h),
            Center(
              child: Text(
                "Melden Sie sich per Telefon an",
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
            SizedBox(height: 54.h),
            SimpleTextField(
              text: 'E-mail',
              controller: controller.loginEmail,
            ),
            SizedBox(height: 18.h),
            PasswordInputField(
              controller: controller.loginPassword,
            ),
            SizedBox(height: 9.h),
            GestureDetector(
              onTap: (){
                Get.toNamed(kResetPasswordRoute);
              },
              child: Text(
                "Passwort vergessen?",
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: kBlueTextColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Neuer Benutzer?",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: kBlackTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(kUserInfoRoute);
                  },
                  child: Text(
                    " Hier registrieren",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: kBlueTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 70.h),
            InkWell(
              onTap: (){
                controller.signIn(context);
              },
              child: const CustomButton(text: "Anmelden"),
            ),
          ],
        ),
      ),
    ));
  }  
}
