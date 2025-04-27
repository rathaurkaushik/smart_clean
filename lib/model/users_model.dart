class UsersModel {
  String? email;
  String? name;
  String? phone;
  String? uid;
  String? id;

  //constructor
  UsersModel({this.uid, this.name, this.phone, this.email, this.id
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
        uid: json['uid'] as String?,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        id: json['id'] as String?,
        email: json['email'] as String?);
  }
}
