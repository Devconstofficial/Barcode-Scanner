import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  final String screenTitle;
  final String className;
  final VoidCallback? onBackButtonTap;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<Widget> actions;
  final double leadingWidth;
  final Color screenTitleColor;
  final Widget? leadingWidget;
  final Widget? title;
  final bool backIcon;
  final bool? centerTitle;
  final Color? backIconColor;

  const CustomAppBar(
      {super.key,
      this.screenTitle = "",
      this.backIcon = true,
      this.className = "",
      this.actions = const [],
      this.onBackButtonTap,
      required this.scaffoldKey,
      this.leadingWidth = 56,
      this.centerTitle,
      this.screenTitleColor = kBlackTextColor,
      this.leadingWidget,
      this.backIconColor = kBlackTextColor,
      this.title});

  @override
  Widget build(BuildContext context) {
    print('=============class name$className ${leadingWidth == 0.0}');
    return AppBar(
      scrolledUnderElevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: actions,
      leadingWidth: leadingWidth,
      leading: backIcon
          ? GestureDetector(
              onTap: onBackButtonTap ??
                  () {
                    Get.back();
                  },
              child:
                  Padding(
                      padding: EdgeInsets.only(
                        left: 10.w,
                      ),
                      child: Icon(
                              Icons.arrow_back_ios,
                              size: 25,
                              color: backIconColor,
                            )),
            )
          : const SizedBox(
              width: 0,
              height: 0,
            ),
      title: title ??
          Text(
            screenTitle,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: kBlackTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                height: 0,
              ),)
          ),
      centerTitle: centerTitle ?? false,
      foregroundColor: Colors.transparent,
    );
  }
}
