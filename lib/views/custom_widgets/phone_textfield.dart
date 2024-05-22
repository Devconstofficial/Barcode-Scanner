import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_scanner/utils/app_colors.dart';

class PhoneTextField extends StatefulWidget {
  final ValueChanged<String>? onPhoneNumberChanged;

  const PhoneTextField({Key? key, this.onPhoneNumberChanged}) : super(key: key);

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        hintText: 'Telefonnummer',
        hintStyle: GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: kGreyTextColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        contentPadding: const EdgeInsets.all(15),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: kGreyTextColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusColor: kGreyTextColor,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      initialCountryCode: 'DE',
      onChanged: (phone) {
        final formattedPhoneNumber = phone.completeNumber;
        if (widget.onPhoneNumberChanged != null) {
          widget.onPhoneNumberChanged!(formattedPhoneNumber);
        }
      },
    );
  }
}
