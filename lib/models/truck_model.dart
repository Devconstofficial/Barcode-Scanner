import 'package:cloud_firestore/cloud_firestore.dart';

class Container {
  String adminId;
  String containerId;
  int quantity;
  String date;
  String time;
  int count;
  int scanFailed;
  int scanSuccess;
  bool isCheck;

  Container({
    required this.adminId,
    required this.containerId,
    required this.quantity,
    required this.date,
    required this.time,
    required this.count,
    required this.scanFailed,
    required this.scanSuccess,
    required this.isCheck,
  });

  factory Container.fromJson(Map<String, dynamic> json) {
    return Container(
      adminId: json['adminId'],
      containerId: json['containerId'],
      quantity: json['quantity'],
      date: json['date'],
      time: json['time'],
      count: json['count'],
      scanFailed: json['scanFailed'],
      scanSuccess: json['scanSuccess'],
      isCheck: json['isCheck'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adminId': adminId,
      'containerId': containerId,
      'quantity': quantity,
      'date': date,
      'time': time,
      'count': count,
      'scanFailed': scanFailed,
      'scanSuccess': scanSuccess,
      'isCheck': isCheck,
    };
  }
}

class Truck {
  String adminId;
  String truckName;
  List<Container> containers;
  int totalCount;
  int totalSuccess;
  int totalFail;

  Truck({
    required this.adminId,
    required this.truckName,
    required this.containers,
    required this.totalCount,
    required this.totalSuccess,
    required this.totalFail,
  });

  factory Truck.fromJson(Map<String, dynamic> json) {
    var containersFromJson = json['containers'] as List;
    List<Container> containerList = containersFromJson.map((container) => Container.fromJson(container)).toList();

    return Truck(
      adminId: json['adminId'],
      truckName: json['truckName'],
      containers: containerList,
      totalCount: json['totalCount'],
      totalSuccess: json['totalSuccess'],
      totalFail: json['totalFail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adminId': adminId,
      'truckName': truckName,
      'containers': containers.map((container) => container.toJson()).toList(),
      'totalCount': totalCount,
      'totalSuccess': totalSuccess,
      'totalFail': totalFail,
    };
  }
}
