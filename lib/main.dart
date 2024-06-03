import 'package:barcode_scanner/custom_navbar.dart';
import 'package:barcode_scanner/firebase_options.dart';
import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/utils/route_generator.dart';
import 'package:barcode_scanner/views/screens/auth/sign_in.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/userhome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'utils/screen_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: kAppName,
          initialRoute: '/',
          initialBinding: ScreenBindings(),
          home: moveToNextScreen(),
          getPages: RouteGenerator.getPages(),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(MediaQuery.of(context)
                    .textScaleFactor
                    .clamp(1.0, 1.0)),
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
  moveToNextScreen() {
    final box = GetStorage();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (box.read('role') == 'admin'){
         return  CustomNavBar();
      } else {
        return UserHome();
      } 
    } else {
      return Signin();
    }
  }
}
