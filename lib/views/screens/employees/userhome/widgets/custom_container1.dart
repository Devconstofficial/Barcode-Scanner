import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/controller/user_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContainer1 extends StatefulWidget {
  final double width;

  const CustomContainer1({
    Key? key,
    required this.width,
    this.date,
  }) : super(key: key);
  final RxString? date;

  @override
  _CustomContainer1State createState() => _CustomContainer1State();
}

class _CustomContainer1State extends State<CustomContainer1> {
  UserHomeController controller = Get.put(UserHomeController());
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
                    
                    widget.date!.value = '${_getDayOfWeek(selectedDate!.weekday)} - ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                    print(widget.date!.value);
                    controller.selectedDate.value = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                    print(controller.selectedDate.value);
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
        if (controller.selectedDate.value != '')
          SizedBox(
            height: 20.h,
          ),
        if (controller.selectedDate.value != '')
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
