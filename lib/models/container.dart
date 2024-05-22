import 'dart:convert';

class TContainer {
  final int count;
  final bool isCheck;
  final int scanFail;
  final int scanSuccesses;

  TContainer({
    required this.count,
    required this.isCheck,
    required this.scanFail,
    required this.scanSuccesses,
  });

  TContainer copyWith({
    int? count,
    bool? isCheck,
    int? scanFail,
    int? scanSuccesses,
  }) {
    return TContainer(
      count: count ?? this.count,
      isCheck: isCheck ?? this.isCheck,
      scanFail: scanFail ?? this.scanFail,
      scanSuccesses: scanSuccesses ?? this.scanSuccesses,
    );
  }

  factory TContainer.fromMap(Map<String, dynamic> map) {
    return TContainer(
      count: map['count'] as int,
      isCheck: map['isCheck'] as bool,
      scanFail: map['scan_fail'] as int,
      scanSuccesses: map['scan_successes'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'isCheck': isCheck,
      'scan_fail': scanFail,
      'scan_successes': scanSuccesses,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Container(count: $count, isCheck: $isCheck, scanFail: $scanFail, scanSuccesses: $scanSuccesses)';
  }

  @override
  bool operator ==(covariant TContainer other) {
    if (identical(this, other)) return true;

    return other.count == count &&
        other.isCheck == isCheck &&
        other.scanFail == scanFail &&
        other.scanSuccesses == scanSuccesses;
  }

  @override
  int get hashCode {
    return count.hashCode ^
        isCheck.hashCode ^
        scanFail.hashCode ^
        scanSuccesses.hashCode;
  }
}
