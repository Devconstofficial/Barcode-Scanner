import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/views/screens/admin/adminhome/controller/admin_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminCustomContainer1 extends StatefulWidget {
  final double width;
  RxString? date;

   AdminCustomContainer1({
    super.key,
    required this.width,
    this.date,
  });

  @override
  _AdminCustomContainer1State createState() => _AdminCustomContainer1State();
}

class _AdminCustomContainer1State extends State<AdminCustomContainer1> {
  DateTime? _selectedDate;
  AdminHomeController controller = Get.put(AdminHomeController());
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
                    _selectedDate != null ?
                    controller.date.value = '${_getDayOfWeek(_selectedDate!.weekday)} - ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}': widget.date!.value = '';
                    controller.selectedDate.value = '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
                    controller.fetchTrucks();
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
                widget.date!.value,
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
      return 'Montag';
    case 2:
      return 'Dienstag';
    case 3:
      return 'Mittwoch';
    case 4:
      return 'Donnerstag';
    case 5:
      return 'Freitag';
    case 6:
      return 'Samstag';
    case 7:
      return 'Sonntag';
    default:
      return '';
  }
}

}
