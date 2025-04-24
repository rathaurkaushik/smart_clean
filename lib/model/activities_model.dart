import 'package:cloud_firestore/cloud_firestore.dart';

class ActivitiesModel {
  final String? id;
  final String? status;
  final String? address;
  final DateTime? createdAt;

  ActivitiesModel({this.id, this.status, this.address, this.createdAt});

  factory ActivitiesModel.fromJson(Map<String, dynamic> json) {
    return ActivitiesModel(
      id: json['id'] as String?,
      status: json['status'] as String?,
      address: json['address'] as String?,
      createdAt:
          json['createdAt'] != null ? (json['createdAt'] as Timestamp).toDate() : null,
    );
  }
}
