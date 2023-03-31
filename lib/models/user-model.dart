import 'dart:convert';

List<UsersModel> usersModelFromJson(String str) => List<UsersModel>.from(json.decode(str).map((x) => UsersModel.fromJson(x)));

String usersModelToJson(List<UsersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersModel {
  UsersModel({
    this.fullName,
    this.company,
    this.age,
    this.userId,
  });

  String? fullName;
  String? company;
  String? age;
  String? userId;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
    fullName: json["full_name"],
    company: json["company"],
    age: json["age"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "full_name": fullName,
    "company": company,
    "age": age,
    "userId": userId,
  };
}