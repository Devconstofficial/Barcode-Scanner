import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleTextField extends StatelessWidget {
  final String text;
  final TextEditingController? controller;
  final TextInputType? type;
  final IconData? suffix;
  const SimpleTextField(
      {super.key, required this.text, this.controller, this.type, this.suffix});
      

  @override
  Widget build(BuildContext context) {
    RxBool _isFocused = false.obs;
    return FocusScope(
      onFocusChange: (hasFocus) {
          _isFocused.value = hasFocus;
      },
      child: Container(
        width: 372.w,
        height: 59.h,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.w, color: _isFocused.value ? kBlackTextColor : kTextFieldColor),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              SizedBox(
                width: 318.w,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: TextField(
                    controller: controller,
                    keyboardType: type ?? TextInputType.visiblePassword,
                    decoration: InputDecoration.collapsed(
                      hintText: text,
                      hintStyle: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: kGreyTextColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              suffix != null
                  ? Icon(
                      suffix,
                      size: 25,
                      color: kTextFieldColor,
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
