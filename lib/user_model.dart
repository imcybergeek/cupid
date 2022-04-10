// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    required this.userDetails,
    required this.token,
  });

  UserDetails userDetails;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userDetails: UserDetails.fromJson(json["user_details"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user_details": userDetails.toJson(),
        "token": token,
      };
}

class UserDetails {
  UserDetails({
    required this.fullName,
    required this.email,
    required this.mobileNo,
    required this.gender,
    required this.dob,
    required this.name,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String fullName;
  String email;
  String mobileNo;
  String gender;
  DateTime dob;
  String name;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        fullName: json["full_name"],
        email: json["email"],
        mobileNo: json["mobile_no"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        name: json["name"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "email": email,
        "mobile_no": mobileNo,
        "gender": gender,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "name": name,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
