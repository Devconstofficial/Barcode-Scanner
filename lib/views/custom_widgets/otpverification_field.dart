import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationField extends StatefulWidget {
  final void Function(String) onChanged;

  const OTPVerificationField({Key? key, required this.onChanged})
      : super(key: key);

  @override
  _OTPVerificationFieldState createState() => _OTPVerificationFieldState();
}

class _OTPVerificationFieldState extends State<OTPVerificationField> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: true,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5.r),
        fieldHeight: 70.h,
        fieldWidth: 55.w,
        activeFillColor: kBlueTextColor,
        selectedFillColor: kBlueTextColor,
        inactiveFillColor: kTextFieldColor,
        activeColor: kBlueTextColor,
        selectedColor: kBlueTextColor,
        inactiveColor: kBlueTextColor,
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        widget.onChanged(value);
      },
      onCompleted: (value) {},
    );
  }
}
