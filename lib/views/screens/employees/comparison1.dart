import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_appbar.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:barcode_scanner/views/screens/employees/container_details/controller/container_detail_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/truck_model.dart' as model;
import 'userhome/controller/user_home_controller.dart';

class Comparison1 extends StatelessWidget {
  const Comparison1({super.key});

  @override
  Widget build(BuildContext context) {
    UserHomeController controller = Get.put(UserHomeController());
    ContainerDetailController cont = Get.put(ContainerDetailController());
    RxBool isLoading = false.obs;
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String truckName = arguments['truckName'];
    final int quantity = arguments['quantity'];
    final String containerId = arguments['containerId'];
    final model.Container container = arguments['container'];
    return SafeArea(
        child: Scaffold(
            backgroundColor: kPrimaryBackgroundColor,
            body: Padding(
                padding: EdgeInsets.only(left: 25, right: 25.w),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      const CustomAppBar(
                        showText: false,
                      ),
                      SizedBox(
                        height: 207.h,
                      ),
                      Image.asset(kApprove),
                      SizedBox(
                        height: 42.h,
                      ),
                      Text(
                        'Vergleich erfolgreich',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: kBlackTextColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 42.h,
                      ),
                      Text(
                        'Barcode 1 und Barcode 2 sind gleich',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: kBlackTextColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 173.h,
                      ),
                      InkWell(
                        onTap: () async {
                          try {
                            isLoading.value = true;
                            container.scanSuccess++;
                            container.isCheck =
                                container.scanSuccess + container.scanFailed ==
                                    container.quantity;
                            container.count--;
                            cont.containerCount.value = container.count;
                            if(container.count == 0){
                              container.time = cont.timerValue.value;
                              cont.stopTimer();
                            }

                            print(container.adminId);
                            print(truckName);

                            QuerySnapshot querySnapshot =
                                await FirebaseFirestore.instance
                                    .collection('trucks')
                                    .where('truckName', isEqualTo: truckName)
                                    .get();

                            bool documentFound = false;

                            for (var doc in querySnapshot.docs) {
                              Map<String, dynamic> data =
                                  doc.data() as Map<String, dynamic>;
                              List<dynamic> containers = data['containers'];
                              bool containerFound = false;

                              for (int i = 0; i < containers.length; i++) {
                                if (containers[i]['containerId'] ==
                                        container.containerId &&
                                    containers[i]['adminId'] ==
                                        container.adminId) {
                                  containers[i]['scanSuccess'] =
                                      container.scanSuccess;
                                  containers[i]['isCheck'] = container.isCheck;
                                  containers[i]['count'] = container.count;
                                  if(container.count == 0){
                                    containers[i]['time'] = container.time;
                                  }
                                  containerFound = true;
                                  break;
                                }
                              }

                              if (containerFound) {
                                await doc.reference
                                    .update({'containers': containers});

                                documentFound = true;
                                break;
                              }
                            }

                            if (documentFound) {
                              await controller.fetchTrucks();
                              isLoading.value = false;
                              if(container.count == 0){
                                Get.close(2);
                              } else {
                                Get.close(1);
                              }
                              
                            } else {
                              isLoading.value = false;
                              Get.snackbar(
                                  backgroundColor: kBlackTextColor,
                                  colorText: kWhiteTextColor,
                                  'Fehler!',
                                  'Kein passender Container in Firestore gefunden.');
                            }
                          } catch (error) {
                            isLoading.value = false;
                            print('Fehler beim Aktualisieren des Dokuments: $error');
                          }
                        },
                        child: Obx(() => isLoading.value
                            ? CircularProgressIndicator()
                            : CustomButton(text: 'Weitermachen')),
                      )
                    ])))));
  }
}
