import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? email;
  String? username;
  String? password;

  User({
    this.id,
    this.email,
    this.username,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "password": password,
      };
}

UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
  String? accessToken;
  String? userId;

  UserLogin({
    this.accessToken,
    this.userId,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        accessToken: json["accessToken"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "user_id": userId,
      };
}
