
import 'package:barcode_scanner/views/screens/admin/addusers/controller/user_management_controller.dart';
import 'package:barcode_scanner/views/screens/admin/dailyUpdates/controller/daily_update_controller.dart';
import 'package:barcode_scanner/views/screens/admin/data_entering/controller/data_entering_controller.dart';
import 'package:barcode_scanner/views/screens/auth/controller/auth_controller.dart';
import 'package:barcode_scanner/views/screens/employees/container_details/controller/container_detail_controller.dart';
import 'package:barcode_scanner/views/screens/employees/scanfinished/controller/scan_finished_controller.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/controller/user_home_controller.dart';
import 'package:get/get.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => DataEnteringController());
    Get.lazyPut(() => UserHomeController());
    Get.lazyPut(() => ContainerDetailController());
    Get.lazyPut(() => ScanFinishedController());
    Get.lazyPut(() => DailyUpdateController());
    Get.lazyPut(() => UserManagementController());
  }
}
