import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:barcode_scanner/views/custom_widgets/password_textfield.dart';
import 'package:barcode_scanner/views/custom_widgets/phone_textfield.dart';
import 'package:barcode_scanner/views/custom_widgets/simpletext_field.dart';
import 'package:barcode_scanner/views/screens/admin/addusers/controller/user_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
                        Expanded(
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
    final UserManagementController controller =
        Get.put(UserManagementController());
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        SimpleTextField(
          text: 'Vollständiger Name',
          controller: controller.adminName,
        ),
        SizedBox(
          height: 27.h,
        ),
        SimpleTextField(text: 'E-Mail', controller: controller.adminEmail),
        SizedBox(
          height: 27.h,
        ),
        PasswordInputField(controller: controller.adminPassword),
        SizedBox(
          height: 27.h,
        ),
        PhoneTextField(
          onPhoneNumberChanged: (value) {
            controller.adminContact.text = value;
          },
        ),
        SizedBox(
          height: 170.h,
        ),
        CustomButton(
            onPressed: () {
              controller.addAdmin(context);
            },
            text: 'Benutzer hinzufügen')
      ],
    );
  }
}

class AddUser extends StatefulWidget {
  AddUser({Key? key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final UserManagementController controller =
      Get.put(UserManagementController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.h,
        ),
        SimpleTextField(
          text: 'Vollständiger Name',
          controller: controller.userName,
        ),
        SizedBox(
          height: 27.h,
        ),
        SimpleTextField(text: 'E-Mail', controller: controller.userEmail),
        SizedBox(
          height: 27.h,
        ),
        PasswordInputField(controller: controller.userPassword),
        SizedBox(
          height: 27.h,
        ),
        PhoneTextField(
          onPhoneNumberChanged: (value) {
            controller.userContact.text = value;
          },
        ),
        SizedBox(
          height: 170.h,
        ),
        CustomButton(
            onPressed: () {
              controller.addUser(context);
            },
            text: 'Benutzer hinzufügen')
      ],
    );
  }
}

class ExistingUsers extends StatelessWidget {
  final UserManagementController controller =
      Get.put(UserManagementController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 36.h,
            ),
            for (var item in controller.userList) ...{
              Container(
                width: 378.w,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 32.w, top: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['isAdmin'] == true
                                ? 'Administrator'
                                : 'Benutzer',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                color: item['isAdmin'] == true
                                    ? kGreenTextColor
                                    : kBlueTextColor,
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
                            item['name'],
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
                            item['contact'],
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
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.delete_outlined,
                            color: kRedContainerColor,
                          ),
                          onPressed: () {
                            Get.defaultDialog(
                              title: 'Benutzer löschen',
                              middleText:
                                  'Möchten Sie diesen Benutzer wirklich löschen?',
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: Text('Abbrechen',
                                      style: TextStyle(color: kBlueTextColor)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    controller.deleteUser(item['id']);
                                    Get.back();
                                  },
                                  child: Text('Löschen',
                                      style: TextStyle(color: kBlueTextColor)),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              )
            },
          ],
        ),
      ),
    );
  }
}
