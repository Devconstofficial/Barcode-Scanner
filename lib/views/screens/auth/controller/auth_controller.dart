import 'package:barcode_scanner/utils/app_strings.dart';
import 'package:barcode_scanner/views/screens/employees/userhome/controller/user_home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../models/user.dart';
import '../../../../utils/app_colors.dart';
import '../../admin/adminhome/controller/admin_home_controller.dart';

class AuthController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeyLogin = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeySignUp = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyForgotPassword =
      GlobalKey<ScaffoldState>();
  TextEditingController loginEmail = TextEditingController(),
      loginPassword = TextEditingController(),
      forgotEmail = TextEditingController(),
      signUpEmail = TextEditingController(),
      signUpPassword = TextEditingController(),
      signUpName = TextEditingController(),
      signUpContact = TextEditingController();
  RxInt selectedIndex = 1.obs;
  RxInt selectedIndexSignUp = (-1).obs;
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final box = GetStorage();
  RxString selectedRole = ''.obs;

  Future signup(BuildContext context) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
                child: CircularProgressIndicator(color: kBlueTextColor),
              ));
      if (selectedIndexSignUp.value == -1) {
        Navigator.of(context).pop();
        Get.snackbar(
          'Ungültiger Benutzer',
          "Benutzertyp nicht ausgewählt, bitte wählen Sie den Benutzertyp.",
          backgroundColor: kBlackTextColor,
          colorText: kWhiteTextColor,
        );
      } else{
        
      
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: signUpEmail.text.trim(),
              password: signUpPassword.text.trim());
      String uid = userCredential.user!.uid;
      UserModel newUser = UserModel(
        id: uid,
        name: signUpName.text.trim(),
        email: signUpEmail.text.trim(),
        contact: signUpContact.text.trim(),
        isAdmin: selectedIndexSignUp.value == 0,
      );
      await _db.collection('users').doc(uid).set(newUser.toJson());
      Navigator.of(context).pop();
      if (selectedIndexSignUp.value == 0) {
        box.write('role', 'admin');
        box.write('password', signUpPassword.text.trim());
        box.write('email', signUpEmail.text.trim());
        box.write('name', signUpName.text.trim());
        signUpName.clear();
        signUpContact.clear();
        signUpEmail.clear();
        signUpPassword.clear();
        selectedRole.value = '';
        selectedIndexSignUp.value = -1;
        Get.offAllNamed(kCustomNavBarRoute);
      } else {
        box.write('role', 'user');
        box.write('email', signUpEmail.text.trim());
        box.write('password', signUpPassword.text.trim());
        box.write('name', signUpName.text.trim());
        signUpName.clear();
        signUpContact.clear();
        signUpEmail.clear();
        signUpPassword.clear();
        selectedRole.value = '';
        selectedIndexSignUp.value = -1;
        Get.offAllNamed(kUserHomeRoute);
      }
      Get.snackbar(
          backgroundColor: kGreenContainerColor,
          colorText: kWhiteTextColor,
          'Glückwunsch',
          'Ihr Konto wurde erfolgreich erstellt!');
      }
      
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      Get.snackbar(
          backgroundColor: kBlackTextColor,
          colorText: kWhiteTextColor,
          'Fehler!!',
          "Das Konto konnte nicht erstellt werden! Bitte versuchen Sie es später erneut.");
    } catch (e) {
      Navigator.of(context).pop();
      Get.snackbar(
          backgroundColor: kBlackTextColor,
          colorText: kWhiteTextColor,
          'Fehler!!',
          "Ein unerwarteter Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.");
    }
  }

  Future logout() async {
    try {
      await _auth.signOut();
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        print('Eingeloggte Benutzer-ID: ${currentUser.uid}');
      } else {
        print('Kein Benutzer eingeloggt');
      }
      box.write('role', '');
      box.write('password', '');
      box.write('email', '');
      box.write('name', '');
      Get.offAllNamed(kUserSigninRoute);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        backgroundColor: kBlackTextColor,
        colorText: kWhiteTextColor,
        'Fehler!',
        'Abmelden nicht möglich. Bitte versuchen Sie es später erneut.',
      );
    }
  }

  Future signIn(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(color: kBlueTextColor),
            ));
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: loginEmail.text.trim(), password: loginPassword.text.trim());

      User? user = userCredential.user;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _db.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          bool isAdmin = userDoc['isAdmin'];
          Navigator.of(context).pop();
          if (isAdmin) {
            box.write('role', 'admin');
            box.write('password', loginPassword.text.trim());
            box.write('email', loginEmail.text.trim());
            box.write('name', userDoc['name']);
            loginEmail.clear();
            loginPassword.clear();
            Get.offAllNamed(kCustomNavBarRoute);
          } else {
            box.write('role', 'user');
            box.write('password', loginPassword.text.trim());
            box.write('email', loginEmail.text.trim());
            box.write('name', userDoc['name']);
            loginEmail.clear();
            loginPassword.clear();
            Get.offAllNamed(kUserHomeRoute);
          }
        } else {
          Navigator.of(context).pop();
          Get.snackbar(
              backgroundColor: kBlackTextColor,
              colorText: kWhiteTextColor,
              'Fehler',
              'Benutzerdaten nicht gefunden. Bitte versuchen Sie es später erneut.');
        }
      } else {
        Navigator.of(context).pop();
        Get.snackbar(
            backgroundColor: kBlackTextColor,
            colorText: kWhiteTextColor,
            'Fehler',
            'Anmeldung fehlgeschlagen. Bitte versuchen Sie es später erneut.');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      Get.snackbar(
          backgroundColor: kBlackTextColor,
          colorText: kWhiteTextColor,
          'Fehler',
          "Ungültige Anmeldeinformationen! Bitte erneut eingeben!");
    }
  }

  Future<void> forgotPassword(BuildContext context) async {
    if (forgotEmail.text.trim().isEmpty) {
      Get.snackbar(
          backgroundColor: kBlackTextColor,
          colorText: kWhiteTextColor,
          'Fehler',
          'Bitte geben Sie die registrierte E-Mail-Adresse ein.');
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(color: kBlueTextColor),
      ),
    );

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: forgotEmail.text.trim())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: forgotEmail.text.trim());

        Navigator.of(context).pop();
        Get.snackbar(
            backgroundColor: kGreenContainerColor,
            colorText: kWhiteTextColor,
            'Erfolg',
            'E-Mail zum Zurücksetzen des Passworts gesendet. Bitte überprüfen Sie Ihren Posteingang.');
        Navigator.pop(context);
      } else {
        Navigator.of(context).pop();
        Get.snackbar(
            backgroundColor: kBlackTextColor,
            colorText: kWhiteTextColor,
            'Fehler',
            'Kein Eintrag mit dieser E-Mail-Adresse gefunden.');
      }
    } catch (e) {
      Navigator.of(context).pop();
      Get.snackbar(
          backgroundColor: kBlackTextColor,
          colorText: kWhiteTextColor,
          'Fehler',
          'Ein unerwarteter Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.');
    }
  }
}
