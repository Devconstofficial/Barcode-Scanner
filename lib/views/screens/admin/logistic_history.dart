import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'adminhome/controller/admin_home_controller.dart';
import 'adminhome/widgets/admin_custom_container1.dart';
import 'adminhome/widgets/admin_custom_container2.dart';
import 'adminhome/widgets/admin_custom_container3.dart';

class LogisticHistory extends StatefulWidget {
  const LogisticHistory({super.key});

  @override
  State<LogisticHistory> createState() => _LogisticHistoryState();
}

class _LogisticHistoryState extends State<LogisticHistory> {
  int counts = 0;
  bool isLoading = true;
  bool hasError = false;
  AdminHomeController controller1 =
        Get.put(AdminHomeController());

  @override
  void initState() {
    super.initState();
    getTrucks();
  }

  Future<void> getTrucks() async {
    try {
      await Future.delayed(Duration(seconds: 3));
      

      setState(() {
        controller1.fetchTrucks();
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryBackgroundColor,
        body: Padding(
          padding: EdgeInsets.only(left: 25.w, right: 25.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  "Logistikgeschichte",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: kBlackTextColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(height: 21.h),
                Text(
                  "Kalenderwoche auswählen",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: kBlackTextColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(height: 7.h),
                AdminCustomContainer1(
                  width: 110.w,
                  date: controller1.date,
                ),
                SizedBox(
                  height: 8.h,
                ),
                if (isLoading)
                  Center(child: CircularProgressIndicator())
                else if (hasError)
                  Center(child: Text('Unable to load data'))
                else ...[
                  AdminCustomContainer2(
                count: controller1.trucksData.length,
                lilaCount: controller1.lilaCount,
                containerCount: controller1.containerCount,
              ),
              SizedBox(
                height: 8.h,
              ),
              Obx(
                ()=> GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.65),
                  ),
                  itemCount: controller1.truckList.length,
                  itemBuilder: (context, index) {
                    return AdminCustomContainer3(
                      text: controller1.truckList[index].truckName,
                      containers: controller1.truckList[index].containers,
                    );
                  },
                ),
              ),
                       
                ],
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
