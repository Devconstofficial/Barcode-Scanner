import 'package:barcode_scanner/views/custom_widgets/phone_textfield.dart';
import 'package:barcode_scanner/views/custom_widgets/simpletext_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/common_code.dart';
import '../../custom_widgets/custom_scaffold.dart';
import '../../custom_widgets/password_textfield.dart';
import 'controller/auth_controller.dart';

class UserInfo extends GetView<AuthController> {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: '',
      isFullBody: true,
      showAppBarBackButton: false,
      isBackIcon: false,
      scaffoldKey: controller.scaffoldKeySignUp,
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
              SizedBox(height: 50.h),
              Center(
                child: Text(
                  "Geben Sie Ihren Namen und Ihre Telefonnummer ein",
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
              SizedBox(height: 30.h),
              SimpleTextField(
                text: 'Name',
                controller: controller.signUpName,
              ),
              SizedBox(height: 18.h),
              SimpleTextField(
                text: 'E-mail',
                controller: controller.signUpEmail,
              ),
              SizedBox(height: 18.h),
              PasswordInputField(
                controller: controller.signUpPassword,
              ),
              SizedBox(
                height: 18.h,
              ),
              PhoneTextField(
                onPhoneNumberChanged: (value) {
                  controller.signUpContact.text = value;
                },
              ),
              // SizedBox(height: 18.h,),
              Obx(
                () => Center(
                  child: Container(
                    width: 372.w,
                    height: 59.h,
                    padding: EdgeInsets.symmetric(horizontal: 23.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: DropdownButton<String>(
                      value: controller.selectedRole.value.isEmpty
                          ? null
                          : controller.selectedRole.value,
                      hint: Text(
                        'Wählen Sie die Benutzerrolle aus        ',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: kGreyTextColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      elevation: 16,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400),
                      underline: Container(height: 0),
                      onChanged: (String? newValue) {
                        controller.selectedRole.value = newValue ?? '';
                        if(newValue! == 'Admin'){
                          controller.selectedIndexSignUp.value = 0;
                        } 
                        if(newValue == 'User'){
                          controller.selectedIndexSignUp.value = 1;
                        } 
                      },

                      items: <String>['Admin', 'User']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              InkWell(
                onTap: () {
                  controller.signup(context);
                },
                child: const CustomButton(text: "Registrieren"),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bereits ein Konto?",
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
                      Get.back();
                    },
                    child: Text(
                      " Anmelden",
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
            ],
          ),
        ),
      ),
    );
  }
}
