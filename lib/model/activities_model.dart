import 'package:cloud_firestore/cloud_firestore.dart';

class ActivitiesModel {
  final String? id;
  final String? status;
  final String? address;
  final DateTime? createdAt;
  final DateTime? acceptedAt;
  final DateTime? completedAt;

  ActivitiesModel({
    this.id,
    this.status,
    this.address,
    this.createdAt,
    this.acceptedAt,
    this.completedAt,
  });

  factory ActivitiesModel.fromJson(Map<String, dynamic> json) {
    return ActivitiesModel(
      id: json['id'] as String?,
      status: json['status'] as String?,
      address: json['address'] as String?,
      createdAt: _parseDate(json['createdAt']),
      acceptedAt: _parseDate(json['acceptedAt']),
      completedAt: _parseDate(json['completedAt']),
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String && value.isEmpty) return null;
    return null;
  }
}
