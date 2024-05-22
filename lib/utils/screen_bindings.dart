
import 'package:barcode_scanner/views/screens/admin/data_entering/controller/data_entering_controller.dart';
import 'package:get/get.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => DataEnteringController());
  }
}
