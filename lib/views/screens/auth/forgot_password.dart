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


class ForgotPassword extends GetView<AuthController> {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      className: runtimeType.toString(), 
      screenName: '', 
      isFullBody: false,
      showAppBarBackButton: true,
      isBackIcon: true,
      scaffoldKey: controller.scaffoldKeyForgotPassword,
      onNotificationListener: (notificationInfo) {
        if (notificationInfo.runtimeType == UserScrollNotification) {
          CommonCode().removeTextFieldFocus();
        }
        return false;
      },
      gestureDetectorOnTap: CommonCode().removeTextFieldFocus, 
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Text(
              "Passwort vergessen",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: kBlackTextColor,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              "Bitte geben Sie Ihre registrierte E-Mail-Adresse zum Zurücksetzen des Passworts ein.",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: kBlackTextColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            SizedBox(height: 54.h),
            SimpleTextField(
              text: 'Email',
              controller: controller.forgotEmail,
            ),
            
            SizedBox(height: 70.h),
            InkWell(
              onTap: (){
                controller.forgotPassword(context);
              },
              child: const CustomButton(text: "Bestätigen"),
            ),
          ],
        ),
      ));
  }  
}
