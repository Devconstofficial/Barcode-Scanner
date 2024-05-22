import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/widgets/custom_container1.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/widgets/custom_container2.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/widgets/custom_container3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../cubits/truck_containers/cubit.dart';

class LogisticHistory extends StatefulWidget {
  const LogisticHistory({super.key});

  @override
  State<LogisticHistory> createState() => _LogisticHistoryState();
}

class _LogisticHistoryState extends State<LogisticHistory> {
  int counts = 0;
  @override
  void initState() {
    super.initState();
    getTrucks();
  }

  Future<void> getTrucks() async {
    final dataCubit = BlocProvider.of<DataCubit>(
      context,
    );
    dataCubit.getAllTruckData();
    int? count = await dataCubit.getTotalContainerCount();
    setState(() {
      counts = count ?? 0;
    });
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
                SizedBox(
                  height: 10.h,
                ),
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
                SizedBox(
                  height: 21.h,
                ),
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
                SizedBox(
                  height: 7.h,
                ),
                CustomContainer1(
                  width: 110.w,
                ),
                SizedBox(
                  height: 8.h,
                ),
                InkWell(
                    onTap: () {
                      Get.toNamed(kContainerDetailsRoute);
                    },
                    child: CustomContainer2(
                      count: counts,
                    )),
                SizedBox(
                  height: 8.h,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.65),
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return CustomCOntainer3(text: "Lilla $index");
                  },
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
