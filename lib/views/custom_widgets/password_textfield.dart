import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordInputField extends StatefulWidget {
  const PasswordInputField({super.key, this.controller});
  final TextEditingController? controller;
  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: Container(
        width: 372.w,
        height: 59.h,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1.w,
                color: _isFocused ? kBlackTextColor : kTextFieldColor),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              const Icon(
                Icons.lock,
                color: kTextFieldColor,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  obscureText: _obscureText,
                  keyboardType: TextInputType.visiblePassword,
                  controller: widget.controller,
                  decoration: InputDecoration.collapsed(
                    focusColor: Colors.black,
                    hintText: 'Passwort',
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
              IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: kTextFieldColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
