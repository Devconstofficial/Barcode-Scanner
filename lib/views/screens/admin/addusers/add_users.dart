import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:barcode_scanner/views/custom_widgets/password_textfield.dart';
import 'package:barcode_scanner/views/custom_widgets/phone_textfield.dart';
import 'package:barcode_scanner/views/custom_widgets/simpletext_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({Key? key});

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryBackgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32.h),
                Text(
                  "Benutzer hinzufügen",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: kBlackTextColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(height: 27.h),
                SizedBox(
                  height: 700.h,
                  width: 450.w,
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          labelStyle: TextStyle(
                            color: kBlueTextColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          unselectedLabelStyle: TextStyle(
                            color: kGreyTextColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          indicatorColor: kBlueTextColor,
                          tabs: const [
                            Tab(
                              text: 'existierende Benutzer',
                            ),
                            Tab(
                              text: 'Benutzer hinzufügen',
                            ),
                            Tab(
                              text: 'Administrator hinzufügen',
                            ),
                          ],
                        ),
                        const Expanded(
                          child: TabBarView(
                            children: [
                              ExistingUsers(),
                              AddUser(),
                              AddAdmin(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddAdmin extends StatefulWidget {
  const AddAdmin({Key? key});

  @override
  State<AddAdmin> createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        const SimpleTextField(text: 'Vollständiger Name'),
        SizedBox(
          height: 27.h,
        ),
        PhoneTextField(),
        SizedBox(
          height: 27.h,
        ),
        const PasswordInputField(),
        SizedBox(
          height: 290.h,
        ),
        const CustomButton(text: 'Benutzer hinzufügen'),
      ],
    );
  }
}

class AddUser extends StatefulWidget {
  const AddUser({Key? key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        const SimpleTextField(text: 'Vollständiger Name'),
        SizedBox(
          height: 27.h,
        ),
        PhoneTextField(),
        SizedBox(
          height: 290.h,
        ),
        const CustomButton(text: 'Benutzer hinzufügen')
      ],
    );
  }
}

class ExistingUsers extends StatelessWidget {
  const ExistingUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 36.h,
        ),
        Container(
          width: 368.w,
          height: 103.h,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            shadows: [
              BoxShadow(
                color: kBoxShadowColor,
                blurRadius: 4.r,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 32.w, top: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Benutzer",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: kBlueTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "John Gillbert",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: kBlackTextColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "+49 163 555 1546",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: kGreyTextColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 17.h, left: 160.w),
                child: const Column(
                  children: [
                    Icon(
                      Icons.delete_outlined,
                      color: kRedContainerColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
