// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
    UserModel({
        this.id,
        this.name,
        this.type,
        this.address,
        this.phone,
        this.user,
        this.password,
        this.avater,
        this.lat,
        this.lng,
    });

    String? id;
    String? name;
    String? type;
    String? address;
    String? phone;
    String? user;
    String? password;
    String? avater;
    String? lat;
    String? lng;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        address: json["address"] == null ? null : json["address"],
        phone: json["phone"] == null ? null : json["phone"],
        user: json["user"] == null ? null : json["user"],
        password: json["password"] == null ? null : json["password"],
        avater: json["avater"] == null ? null : json["avater"],
        lat: json["lat"] == null ? null : json["lat"],
        lng: json["lng"] == null ? null : json["lng"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "address": address == null ? null : address,
        "phone": phone == null ? null : phone,
        "user": user == null ? null : user,
        "password": password == null ? null : password,
        "avater": avater == null ? null : avater,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
    };
}
