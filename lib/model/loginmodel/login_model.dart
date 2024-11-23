// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int? id;
  int? districtId;
  String? districtName;
  String? lifelineId;
  String? name;
  String? username;
  String? password;
  String? mobile;
  String? email;
  String? upiId;
  String? accountNumber;
  String? ifscCode;
  String? image;
  String? signature;
  DateTime? dateOfBirth;
  String? place;
  String? address;
  String? otherDocumentDetails;
  String? aadhaarNumber;
  int? accountAmount;
  int? status;
  int? terms;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? rememberToken;
  String? cmFirebaseToken;
  String? deviceToken;
  String? temporaryToken;
  List<dynamic>? translations;

  LoginModel({
    this.id,
    this.districtId,
    this.districtName,
    this.lifelineId,
    this.name,
    this.username,
    this.password,
    this.mobile,
    this.email,
    this.upiId,
    this.accountNumber,
    this.ifscCode,
    this.image,
    this.signature,
    this.dateOfBirth,
    this.place,
    this.address,
    this.otherDocumentDetails,
    this.aadhaarNumber,
    this.accountAmount,
    this.status,
    this.terms,
    this.createdAt,
    this.updatedAt,
    this.rememberToken,
    this.cmFirebaseToken,
    this.deviceToken,
    this.temporaryToken,
    this.translations,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["id"],
        districtId: json["district_id"],
        districtName: json["district_name"],
        lifelineId: json["lifeline_id"],
        name: json["name"],
        username: json["username"],
        password: json["password"],
        mobile: json["mobile"],
        email: json["email"],
        upiId: json["upi_id"],
        accountNumber: json["account_number"],
        ifscCode: json["ifsc_code"],
        image: json["image"],
        signature: json["signature"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        place: json["place"],
        address: json["address"],
        otherDocumentDetails: json["other_document_details"],
        aadhaarNumber: json["aadhaar_number"],
        accountAmount: json["account_amount"],
        status: json["status"],
        terms: json["terms"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        rememberToken: json["remember_token"],
        cmFirebaseToken: json["cm_firebase_token"],
        deviceToken: json["device_token"],
        temporaryToken: json["temporary_token"],
        translations: json["translations"] == null
            ? []
            : List<dynamic>.from(json["translations"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "district_id": districtId,
        "district_name": districtName,
        "lifeline_id": lifelineId,
        "name": name,
        "username": username,
        "password": password,
        "mobile": mobile,
        "email": email,
        "upi_id": upiId,
        "account_number": accountNumber,
        "ifsc_code": ifscCode,
        "image": image,
        "signature": signature,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "place": place,
        "address": address,
        "other_document_details": otherDocumentDetails,
        "aadhaar_number": aadhaarNumber,
        "account_amount": accountAmount,
        "status": status,
        "terms": terms,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "remember_token": rememberToken,
        "cm_firebase_token": cmFirebaseToken,
        "device_token": deviceToken,
        "temporary_token": temporaryToken,
        "translations": translations == null
            ? []
            : List<dynamic>.from(translations!.map((x) => x)),
      };
}
