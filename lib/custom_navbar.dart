// ignore_for_file: library_private_types_in_public_api
import 'package:barcode_scanner/utils/app_colors.dart';
import 'package:barcode_scanner/views/screens/admin/addusers/add_users.dart';
import 'package:barcode_scanner/views/screens/admin/adminhome/admin_home.dart';
import 'package:barcode_scanner/views/screens/admin/dailyUpdates/daily_update.dart';
import 'package:barcode_scanner/views/screens/admin/logistic_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNavBar extends StatefulWidget {
  static const String id = 'MyNavBar';

  static final GlobalKey<_CustomNavBarState> navBarKey =
      GlobalKey<_CustomNavBarState>();

  const CustomNavBar({super.key});

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  List<Widget> screens = [
    const AdminHome(),
    const DailyUpdate(),
    const LogisticHistory(),
    const AddUsers(),
  ];

  int currentIndex = 0;
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(4, (index) => index == currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: CustomNavBar.navBarKey,
      backgroundColor: const Color.fromARGB(255, 116, 73, 73),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          _buildNavBarItem(
            index: 0,
            svgPath: 'assets/images/home.svg',
            label: 'Home',
          ),
          _buildNavBarItem(
            index: 1,
            svgPath: 'assets/images/scan.svg',
            label: 'P1',
          ),
          _buildNavBarItem(
            index: 2,
            svgPath: 'assets/images/time.svg',
            label: 'P2',
          ),
          _buildNavBarItem(
            index: 3,
            svgPath: 'assets/images/profile.svg',
            label: 'P3',
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
            isSelected = List.generate(4, (i) => i == index);
          });
        },
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem({
    required int index,
    required String svgPath,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Align(
        alignment: Alignment.center,
        child: SvgPicture.asset(
          svgPath,
          color: isSelected[index] ? kBlueTextColor : kTextFieldColor,
        ),
      ),
      label: isSelected[index] ? '' : label,
      backgroundColor: Colors.white,
    );
  }
}
