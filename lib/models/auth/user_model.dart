class UserModel {
  String displayName;
  String email;
  String phone;
  String uid;
  String picture;

  UserModel({this.displayName, this.email, this.phone, this.uid, this.picture});

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return;
    }

    email = json['email'];
    displayName = json['displayName'];
    phone = json['phone'];
    uid = json['uId'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'phone': phone,
      'uId': uid,
      'picture': picture,
    };
  }
}
