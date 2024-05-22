import 'package:barcode_scanner/cubits/phone_auth/cubit.dart';
import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/custom_widgets/phone_textfield.dart';
import 'package:barcode_scanner/views/screens/admin/admin_signin.dart';
import 'package:barcode_scanner/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserSignin extends StatefulWidget {
  const UserSignin({super.key});

  @override
  State<UserSignin> createState() => _UserSigninState();
}

class _UserSigninState extends State<UserSignin> {
  int selectedIndex = 1;
  String phone = "";
  bool showOtpContainer = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryBackgroundColor,
        body: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
          listener: (context, state) {
            if (state is PhoneAuthLoading) {
            } else if (state is PhoneAuthSuccess) {
              setState(() {
                showOtpContainer = true;
              });
              Fluttertoast.showToast(msg: "Wait for verification");
            } else if (state is PhoneAuthFailed) {
              Fluttertoast.showToast(msg: "Invalid phone number!");
            }
          },
          builder: (context, state) {
            if (state is PhoneAuthDefault) {
              return form();
            } else if (state is PhoneAuthLoading) {
              return const FullScreenLoader(
                loading: true,
              );
            }
            return form();
          },
        ),
      ),
    );
  }

  Widget form() {
    return Padding(
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
                    selectedLabelIndex: (index) {
                      setState(() {
                        selectedIndex = index;

                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdminSignin()),
                          );
                        } else if (index == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserSignin()),
                          );
                        }
                      });
                    },
                  )),
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
            SizedBox(height: 200.h),
            InkWell(
                onTap: () async {
                  // if (RegExp(r'^\+\d{1,3}\d{6,14}$').hasMatch(phone)) {
                  //   final authCubit = BlocProvider.of<PhoneAuthCubit>(
                  //     context,
                  //   );
                  //   await authCubit.authenticatePhone(phone);
                  //   showOtpContainer
                  //       ? Get.toNamed(kOTPVerificationRoute)
                  //       : null;
                  // }
                  Get.offAndToNamed(kUserHomeRoute);
                },
                child: const CustomButton(text: "Anmelden")),
          ],
        ),
      ),
    );
  }
}
