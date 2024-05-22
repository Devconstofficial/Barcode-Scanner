import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContainer1 extends StatefulWidget {
  final double width;

  const CustomContainer1({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  _CustomContainer1State createState() => _CustomContainer1State();
}

class _CustomContainer1State extends State<CustomContainer1> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 376.w,
          height: 59.h,
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
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 35.w,
              ),
              Container(
                width: 4.w,
                height: 25.h,
                decoration: const BoxDecoration(color: kGreenContainerColor),
              ),
              SizedBox(
                width: 29.w,
              ),
              Text(
                'Datum auswählen',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: kBlackTextColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(
                width: 110.w,
              ),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  ).then((selectedDate) {
                    setState(() {
                      _selectedDate = selectedDate;
                    });
                  });
                },
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: kBlackTextColor,
                ),
              ),
            ],
          ),
        ),
        if (_selectedDate != null)
          SizedBox(
            height: 20.h,
          ),
        if (_selectedDate != null)
          Container(
            width: 376.w,
            height: 59.h,
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
                ),
              ],
            ),
            child: Row(children: [
              SizedBox(
                width: 35.w,
              ),
              Container(
                width: 4.w,
                height: 25.h,
                decoration: const BoxDecoration(color: kGreenContainerColor),
              ),
              SizedBox(
                width: 29.w,
              ),
              Text(
                _selectedDate != null
                    ? '${_getDayOfWeek(_selectedDate!.weekday)} - ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                    : '',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: kGreenTextColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ]),
          ),
      ],
    );
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tueday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}
