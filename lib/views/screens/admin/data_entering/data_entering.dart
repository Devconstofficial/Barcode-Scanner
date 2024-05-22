import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_appbar.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:barcode_scanner/views/screens/admin/data_entering/controller/data_entering_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../utils/app_images.dart';
import '../../../custom_widgets/simpletext_field.dart';

class DataEnteringScreen extends GetView<DataEnteringController> {
  const DataEnteringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String lilaText = Get.arguments ?? "Lila";

    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: kPrimaryBackgroundColor,
        body: Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w),
          child: SingleChildScrollView(
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const CustomAppBar(
                  showText: false,
                ),
                Row(
                  children: [
                    Image.asset(
                      kTruck2,
                      height: 80.h,
                      width: 80.w,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      lilaText,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: kBlackTextColor,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 48.h,
                ),
                Obx(
                  () => controller.dataList.isNotEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(controller.dataList.length,
                              (index) {
                            final item = controller.dataList[index];
                            return Column(
                              children: [
                                Container(
                                  width: 368.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                      color: kTextFieldColor,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.w, right: 15.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          item["lilaNumber"],
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                              color: kBlackTextColor,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              height: 0,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${item["lilaQuantity"]}',
                                              style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                  color: kBlueTextColor,
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.deleteItem(index);
                                              },
                                              child: const Icon(
                                                Icons.delete_outline,
                                                color: kDeleteIconColor,
                                                size: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 22.h),
                              ],
                            );
                          }),
                        )
                      : Container(),
                ),
                Container(
                  width: 368.w,
                  height: 60.h,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.w, color: kTextFieldColor),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(
                        "Fügen Sie einen Behälter hinzu",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: kBlackTextColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      IconButton(
                        onPressed: () {
                          controller.addContainer.value = true;
                        },
                        icon: const Icon(
                          Icons.add,
                          color: kTextFieldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => controller.addContainer.isTrue
                      ? SizedBox(
                          height: 22.h,
                        )
                      : const SizedBox(),
                ),
                Obx(
                  () => controller.addContainer.isTrue
                      ? Column(
                          children: [
                            SimpleTextField(
                              text: 'Behälter Nummer',
                              controller: controller.lilaNumber,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            SimpleTextField(
                              text: 'Anzahl der Bauteile',
                              controller: controller.lilaQuantity,
                              type: TextInputType.number,
                            ),
                            SizedBox(
                              height: 22.h,
                            ),
                            CustomButton(
                              text: "HINZUFÜGEN",
                              onPressed: () {
                                controller.addDataToList();
                                controller.addContainer.value = false;
                              },
                            )
                          ],
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 40.h, left: 30.w, right: 30.w),
          child: CustomButton(
            text: "ERLEDIGT",
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
