import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_scanner/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  final bool showText;

  const CustomAppBar({super.key, this.showText = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        SizedBox(
          width: 70.w,
        ),
        if (showText)
          Text(
            "OTP überprüfen",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: kBlackTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
          ),
      ],
    );
  }
}
