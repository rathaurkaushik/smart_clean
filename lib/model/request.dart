import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
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

  RequestModel({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.photos,
    this.status,
    this.createdAt,
    this.acceptedAt,
    this.completedAt,
    this.uid,
  });

  // Helper to parse both Timestamp and String to DateTime
  static DateTime? parseDate(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  // Convert Firestore JSON to Model
  factory RequestModel.fromJson(Map<String, dynamic> json, String docId) {
    return RequestModel(
      id: docId,
      name: json['name'] as String?,
      // surname: json['surname'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      photos: json['photos'] as String?,
      status: json['status'] as String?,
      createdAt: parseDate(json['createdAt']),
      acceptedAt: parseDate(json['acceptedAt']),
      completedAt: parseDate(json['completedAt']),
      uid: json['uid'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      // 'surname': surname,
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
