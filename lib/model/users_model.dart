class UsersModel {
  String? email;
  String? name;
  String? phone;
  String? uid;

  //constructor
  UsersModel({this.uid, this.name, this.phone, this.email});

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
        uid: json['uid'] as String?,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?);
  }
}
