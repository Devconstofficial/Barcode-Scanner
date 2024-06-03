import 'package:barcode_scanner/views/screens/auth/forgot_password.dart';
import 'package:barcode_scanner/views/screens/auth/sign_in.dart';
import 'package:barcode_scanner/views/screens/auth/user_info.dart';
import 'package:barcode_scanner/custom_navbar.dart';
import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/utils/screen_bindings.dart';
import 'package:barcode_scanner/views/screens/admin/dailyUpdates/daily_update.dart';
import 'package:barcode_scanner/views/screens/admin/data_entering/controller/data_entering_controller.dart';
import 'package:barcode_scanner/views/screens/admin/data_entering/data_entering.dart';
import 'package:barcode_scanner/views/screens/employees/comparison1.dart';
import 'package:barcode_scanner/views/screens/employees/comparison2.dart';
import 'package:barcode_scanner/views/screens/employees/container_details/container_details.dart';
import 'package:barcode_scanner/views/screens/employees/scanfinished/scan_finished.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/userhome.dart';
import 'package:get/get.dart';

class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: kUserSigninRoute,
          page: () => const Signin(),
          binding: ScreenBindings()),
          GetPage(
          name: kUserInfoRoute,
          page: () => const UserInfo(),
          binding: ScreenBindings()),
      
      GetPage(
          name: kUserHomeRoute,
          page: () => const UserHome(),
          binding: ScreenBindings()),
      GetPage(
          name: kContainerDetailsRoute,
          page: () => const ContainerDetails(),
          binding: ScreenBindings()),
      GetPage(
          name: kComparison1Route,
          page: () => const Comparison1(),
          binding: ScreenBindings()),
      GetPage(
          name: kComparison2Route,
          page: () => const Comparison2(),
          binding: ScreenBindings()),
      GetPage(
          name: kScanFinishedRoute,
          page: () => const ScanFinished(),
          binding: ScreenBindings()),
      GetPage(
          name: kDailyUpdateRoute,
          page: () => const DailyUpdate(),
          binding: ScreenBindings()),
      GetPage(
          name: kCustomNavBarRoute,
          page: () => const CustomNavBar(),
          binding: ScreenBindings()),
      GetPage(
          name: kResetPasswordRoute,
          page: () => const ForgotPassword(),
          binding: ScreenBindings()),
      GetPage(
        name: '/dataEntering',
        page: () => const DataEnteringScreen(),
        binding: BindingsBuilder(() {
          Get.put(DataEnteringController());
        }),
      ),
    ];
  }
}
