import 'package:barcode_scanner/cubits/truck_containers/cubit.dart';
import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/widgets/custom_container1.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/widgets/custom_container2.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/widgets/custom_container3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
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
        body: BlocConsumer<DataCubit, DataState>(
          listener: (context, state) {
            if (state is ContainersLoadFailure || state is TrucksLoadFailure) {
              Fluttertoast.showToast(msg: "Unable to Load Data");
            }
          },
          builder: (context, state) {
            if (state is ContainersLoading ||
                state is TrucksLoading ||
                state is ContainersCountLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ContainersLoadFailure ||
                state is TrucksLoadFailure) {
              return Center(
                child: Image.asset(
                  'assets/images/noData.png',
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Guten Tag!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: kBlackTextColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                            Text(
                              "Mustafa",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: kBlackTextColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Get.off(kUserSigninRoute);
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: kBlueTextColor,
                              ),
                              Text(
                                "Logout",
                                style: TextStyle(color: kBlueTextColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
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
                        child: CustomContainer2(count: counts)),
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
                        int val = index + 1;
                        return CustomCOntainer3(text: "Lila $val");
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
