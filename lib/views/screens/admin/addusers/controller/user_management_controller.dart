import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../models/user.dart';
import '../../../../../utils/app_colors.dart';

class UserManagementController extends GetxController {
  RxList<Map<String, dynamic>> userList = <Map<String, dynamic>>[].obs;
  TextEditingController userName = TextEditingController(),
  userEmail = TextEditingController(),
  userContact = TextEditingController(),
  userPassword = TextEditingController(),
  adminName = TextEditingController(),
  adminEmail = TextEditingController(),
  adminContact = TextEditingController(),
  adminPassword = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final box = GetStorage();

  @override
  void onInit() async {
    super.onInit();
    await fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      final List<Map<String, dynamic>> usersData = querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                'name': doc['name'],
                'email': doc['email'],
                'contact': doc['contact'],
                'isAdmin': doc['isAdmin'],
              })
          .toList();

      userList.assignAll(usersData);
    } catch (error) {
      Get.snackbar(
          backgroundColor: kBlackTextColor,
          colorText: kWhiteTextColor,
          'Fehler',
          'Fehler beim Abrufen von Benutzern: $error');
      print('Fehler beim Abrufen von Benutzern: $error');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      userList.removeWhere((user) => user['id'] == userId);
    } catch (error) {
      Get.snackbar(
          backgroundColor: kBlackTextColor,
          colorText: kWhiteTextColor,
          'Fehler',
          'Fehler beim Löschen von Benutzern: $error');
    }
  }

  Future addUser(BuildContext context) async {
    try {
      if(userEmail.text.isEmpty || userName.text.isEmpty || userPassword.text.isEmpty || userContact.text.isEmpty){
        return Get.snackbar(
          backgroundColor: kBlackTextColor,
          colorText: kWhiteTextColor,
          'Fehler!!',
          "Benutzerkonto konnte nicht erstellt werden! Alle Felder sind erforderlich!");
      }
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
                child: CircularProgressIndicator(color: kBlueTextColor),
              ));
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: userEmail.text.trim(),
              password: userPassword.text.trim());
      String uid = userCredential.user!.uid;
      UserModel newUser = UserModel(
        id: uid,
        name: userName.text.trim(),
        email: userEmail.text.trim(),
        contact: userContact.text.trim(),
        isAdmin: false,
      );
      await _db.collection('users').doc(uid).set(newUser.toJson());
      await _auth.signInWithEmailAndPassword(
          email: box.read('email'), password: box.read('password'));
      Navigator.of(context).pop();
      fetchUsers();
      Get.snackbar(
          backgroundColor: kGreenContainerColor,
          colorText: kWhiteTextColor,
          'Herzlichen Glückwunsch',
          'Benutzer wurde erfolgreich hinzugefügt!');
      userName.clear();
      userEmail.clear();
      userPassword.clear();
      userContact.clear();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      Get.snackbar(
          backgroundColor: kBlackTextColor,
          colorText: kWhiteTextColor,
          'Fehler!!',
          "Benutzerkonto konnte nicht erstellt werden! Bitte versuche es später erneut.");
    } catch (e) {
      Navigator.of(context).pop();
      Get.snackbar(
          backgroundColor: kBlackTextColor,
          colorText: kWhiteTextColor,
          'Fehler!!',
          "Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es später erneut.");
    }
  }

  Future addAdmin(BuildContext context) async {
    try {
      if(adminEmail.text.isEmpty || adminName.text.isEmpty || adminPassword.text.isEmpty || adminContact.text.isEmpty){
        return Get.snackbar(
          backgroundColor: kBlackTextColor,
          colorText: kWhiteTextColor,
          'Fehler!!',
          "Benutzerkonto konnte nicht erstellt werden! Alle Felder sind erforderlich!");
      }
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
                child: CircularProgressIndicator(color: kBlueTextColor),
              ));
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: adminEmail.text.trim(),
              password: adminPassword.text.trim());
      String uid = userCredential.user!.uid;
      UserModel newUser = UserModel(
        id: uid,
        name: adminName.text.trim(),
        email: adminEmail.text.trim(),
        contact: adminContact.text.trim(),
        isAdmin: true,
      );
      await _db.collection('users').doc(uid).set(newUser.toJson());
      await _auth.signInWithEmailAndPassword(
          email: box.read('email'), password: box.read('password'));
      Navigator.of(context).pop();
      fetchUsers();
      Get.snackbar(
          backgroundColor: kGreenContainerColor,
          colorText: kWhiteTextColor,
          'Herzlichen Glückwunsch',
          'Benutzer wurde erfolgreich hinzugefügt!');
      adminName.clear();
      adminEmail.clear();
      adminPassword.clear();
      adminContact.clear();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      Get.snackbar(
          backgroundColor: kBlackTextColor,
          colorText: kWhiteTextColor,
          'Fehler!!',
          "Benutzerkonto konnte nicht erstellt werden! Bitte versuche es später erneut.");
    } catch (e) {
      Navigator.of(context).pop();
      Get.snackbar(
          backgroundColor: kBlackTextColor,
          colorText: kWhiteTextColor,
          'Fehler!!',
          "Ein unerwarteter Fehler ist aufgetreten. Bitte versuche es später erneut.");
    }
  }
}
