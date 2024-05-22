import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/custom_widgets/password_textfield.dart';
import 'package:barcode_scanner/views/custom_widgets/phone_textfield.dart';
import 'package:barcode_scanner/views/screens/employees/user_signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminSignin extends StatefulWidget {
  const AdminSignin({super.key});

  @override
  State<AdminSignin> createState() => _AdminSigninState();
}

class _AdminSigninState extends State<AdminSignin> {
  int selectedIndex = 0;
  String? phone;
  void handleTabChange(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminSignin()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserSignin()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryBackgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 29.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Center(child: Image.asset(kAppLogo)),
                SizedBox(height: 28.h),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: FlutterToggleTab(
                      width: 90.w,
                      borderRadius: 30.r,
                      height: 43.h,
                      labels: const ["Administrator", "Mitarbeiter"],
                      selectedTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      unSelectedTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      selectedBackgroundColors: const [Colors.blue],
                      unSelectedBackgroundColors: const [Colors.white],
                      selectedIndex: selectedIndex,
                      selectedLabelIndex: handleTabChange,
                    ),
                  ),
                ),
                SizedBox(height: 41.h),
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
                PhoneTextField(
                  onPhoneNumberChanged: (value) {
                    setState(() {
                      phone = value;
                    });
                  },
                ),
                SizedBox(height: 20.h),
                const PasswordInputField(),
                SizedBox(height: 19.h),
                Text(
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
                SizedBox(height: 79.h),
                InkWell(
                    onTap: () {
                      Get.toNamed(kCustomNavBarRoute);
                    },
                    child: const CustomButton(text: "Anmelden")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
