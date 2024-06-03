import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/utils/app_images.dart';
import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_appbar.dart';
import 'package:barcode_scanner/views/custom_widgets/custom_button.dart';
import 'package:barcode_scanner/views/custom_widgets/simple_button.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/controller/user_home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/truck_model.dart' as model;
import 'container_details/controller/container_detail_controller.dart';

class Comparison2 extends StatefulWidget {
  const Comparison2({super.key});

  @override
  State<Comparison2> createState() => _Comparison2State();
}

class _Comparison2State extends State<Comparison2> {
  UserHomeController controller = Get.put(UserHomeController());
  ContainerDetailController cont = Get.put(ContainerDetailController());
  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.only(left: 25.w, right: 25.w),
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
                      Image.asset(kRejected),
                      SizedBox(
                        height: 42.h,
                      ),
                      Text(
                        'Vergleich fehlgeschlagen',
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
                        height: 233.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SimpleButton(),
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      InkWell(
                        onTap: () async {
                          try {
                            isLoading.value = true;
                            container.scanFailed++;
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
                                  containers[i]['scanFailed'] =
                                      container.scanFailed;
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
