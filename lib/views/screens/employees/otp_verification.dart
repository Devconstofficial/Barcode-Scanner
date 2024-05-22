import 'package:barcode_scanner/cubits/phone_auth/cubit.dart';
import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_appbar.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:barcode_scanner/views/custom_widgets/otpverification_field.dart';
import 'package:barcode_scanner/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

class OTPVerfication extends StatefulWidget {
  const OTPVerfication({super.key});

  @override
  State<OTPVerfication> createState() => _OTPVerficationState();
}

class _OTPVerficationState extends State<OTPVerfication> {
  String otp = "";
  bool logIn = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryBackgroundColor,
        body: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
          listener: (context, state) {
            if (state is OTPAuthFailed) {
              Fluttertoast.showToast(msg: "Wrong OTP Verification Failed!");
            } else if (state is OTPAuthSuccess) {
              setState(() {
                logIn = true;
              });
              Fluttertoast.showToast(msg: "Logged In");
            }
          },
          builder: (context, state) {
            if (state is OTPAuthLoading) {
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
      padding: EdgeInsets.only(left: 25.w, right: 25.w),
      child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CustomAppBar(),
        SizedBox(
          height: 44.h,
        ),
        Text(
          "Der Code wurde an +49 163 555 1546 gesendet",
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              color: kBlackTextColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
        SizedBox(
          height: 80.h,
        ),
        OTPVerificationField(
          onChanged: (val) {
            otp = val;
          },
        ),
        SizedBox(
          height: 25.h,
        ),
        Center(
          child: Text(
            "Sie haben den Code noch nicht erhalten?",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: kBlackTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Center(
          child: Text(
            "Erneut senden",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: kBlueTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 400.h,
        ),
        InkWell(
            onTap: () async {
              if (otp == null || otp!.length < 6) {
                Fluttertoast.showToast(msg: "Enter OTP!");
              } else {
                final authCubit = BlocProvider.of<PhoneAuthCubit>(context);
                await authCubit.authenticateOTP(otp);
                logIn ? Get.toNamed(kUserHomeRoute) : null;
              }
            },
            child: const CustomButton(text: 'Verifizieren'))
      ])),
    );
  }
}
