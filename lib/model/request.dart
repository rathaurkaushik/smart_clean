import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String? id;
  String? name;
  String? surname;
  String? address;
  String? phone;
  String? photos;
  String? status;
  DateTime? createdAt;
  DateTime? acceptedAt;
  DateTime? completedAt;
  String? uid;

  Request({
    this.id,
    this.name,
    this.surname,
    this.address,
    this.phone,
    this.photos,
    this.status,
    this.createdAt,
    this.acceptedAt,
    this.completedAt,
    this.uid,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'address': address,
      'phone': phone,
      'photos': photos,
      'status': status,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'acceptedAt': acceptedAt != null ? Timestamp.fromDate(acceptedAt!) : null,
      'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
      'uid': uid,
    };
  }
}
