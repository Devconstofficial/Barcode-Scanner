import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String? name;
  String email;
  String? contact;
  bool isAdmin;
  UserModel(
      {required this.id,
      this.name,
      required this.email,
      this.contact,
      required this.isAdmin});

  static UserModel empty() => UserModel(
      id: '', name: '', email: '', contact: '', isAdmin: false);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'contact': contact,
      'isAdmin': isAdmin
    };
  }

}
