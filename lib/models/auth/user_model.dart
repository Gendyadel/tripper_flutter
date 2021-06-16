class UserModel {
  String displayName;
  String email;
  String phone;
  String uid;
  bool isEmailVerified;

  UserModel({
    this.displayName,
    this.email,
    this.phone,
    this.uid,
    this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    displayName = json['displayName'];
    phone = json['phone'];
    uid = json['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'phone': phone,
      'uId': uid,
      'isEmailVerified': isEmailVerified,
    };
  }
}
