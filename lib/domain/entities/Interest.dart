import 'dart:convert';

import 'package:projeto_lab/util/enum.dart';

class Interest {
  String id;
  String userId;
  String petId;
  Status status;

  Interest({
    this.id = "",
    required this.userId,
    required this.petId,
    this.status = Status.pending,
  });

  bool isActive() {
    switch (this.status) {
      case Status.pending:
      case Status.accepted:
        return true;

      case Status.refused:
        return false;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != "") 'id': id,
      'userId': userId,
      'petId': petId,
      'status': enumToString(status),
    };
  }

  factory Interest.fromMap(Map<String, dynamic> map) {
    return Interest(
      id: map['id'] ?? "",
      userId: map['userId'],
      petId: map['petId'],
      status: enumFromString(Status.values, map['status']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Interest.fromJson(String source) =>
      Interest.fromMap(json.decode(source));
}

enum Status { pending, accepted, refused }
