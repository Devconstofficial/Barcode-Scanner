import 'dart:convert';
import 'container.dart';

class Truck {
  final String name;
  final TContainer po1251;
  final TContainer po1356;
  final TContainer po1386;
  final TContainer po1740;
  final DateTime date;
  final int totalCount;
  final int totalFail;
  final int totalSuccess;

  Truck({
    required this.name,
    required this.po1251,
    required this.po1356,
    required this.po1386,
    required this.po1740,
    required this.date,
    required this.totalCount,
    required this.totalFail,
    required this.totalSuccess,
  });

  Truck copyWith({
    String? name,
    TContainer? po1251,
    TContainer? po1356,
    TContainer? po1386,
    TContainer? po1740,
    DateTime? date,
    int? totalCount,
    int? totalFail,
    int? totalSuccess,
  }) {
    return Truck(
      name: name ?? this.name,
      po1251: po1251 ?? this.po1251,
      po1356: po1356 ?? this.po1356,
      po1386: po1386 ?? this.po1386,
      po1740: po1740 ?? this.po1740,
      date: date ?? this.date,
      totalCount: totalCount ?? this.totalCount,
      totalFail: totalFail ?? this.totalFail,
      totalSuccess: totalSuccess ?? this.totalSuccess,
    );
  }

  factory Truck.fromMap(Map<String, dynamic> map) {
    return Truck(
      name: map['name'] as String,
      po1251: TContainer.fromMap(map['PO1251'] as Map<String, dynamic>),
      po1356: TContainer.fromMap(map['PO1356'] as Map<String, dynamic>),
      po1386: TContainer.fromMap(map['PO1386'] as Map<String, dynamic>),
      po1740: TContainer.fromMap(map['PO1740'] as Map<String, dynamic>),
      date: DateTime.parse(map['date'] as String),
      totalCount: map['total_count'] as int,
      totalFail: map['total_fail'] as int,
      totalSuccess: map['total_success'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'PO1251': po1251.toMap(),
      'PO1356': po1356.toMap(),
      'PO1386': po1386.toMap(),
      'PO1740': po1740.toMap(),
      'date': date.toIso8601String(),
      'total_count': totalCount,
      'total_fail': totalFail,
      'total_success': totalSuccess,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Truck(name: $name, date: $date, totalCount: $totalCount, totalFail: $totalFail, totalSuccess: $totalSuccess)';
  }

  @override
  bool operator ==(covariant Truck other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.po1251 == po1251 &&
        other.po1356 == po1356 &&
        other.po1386 == po1386 &&
        other.po1740 == po1740 &&
        other.date == date &&
        other.totalCount == totalCount &&
        other.totalFail == totalFail &&
        other.totalSuccess == totalSuccess;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        po1251.hashCode ^
        po1356.hashCode ^
        po1386.hashCode ^
        po1740.hashCode ^
        date.hashCode ^
        totalCount.hashCode ^
        totalFail.hashCode ^
        totalSuccess.hashCode;
  }
}
