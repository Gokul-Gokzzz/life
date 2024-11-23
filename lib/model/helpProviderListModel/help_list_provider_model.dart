
import 'dart:convert';

List<HelpListProviderModel> helpListProviderModelFromJson(String str) => List<HelpListProviderModel>.from(json.decode(str).map((x) => HelpListProviderModel.fromJson(x)));

String helpListProviderModelToJson(List<HelpListProviderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HelpListProviderModel {
    int? id;
    int? districtId;
    int? meghalaId;
    int? unitId;
    String? districtName;
    String? meghalaName;
    String? unitName;
    String? name;
    String? username;
    String? password;
    String? nomineeName;
    int? akpaId;
    String? mobile;
    String? upiId;
    String? image;
    DateTime? dateOfBirth;
    String? age;
    String? joinYear;
    String? lastRenewedDate;
    int? accountAmount;
    int? balanceAmount;
    int? lastDeathId;
    int? previousDeathId;
    DateTime? dateOfDeath;
    String? chequeNumber;
    DateTime? creditedDate;
    int? creditedAmount;
    String? helpImage;
    int? creditedStatus;
    int? status;
    int? deathStatus;
    dynamic createdAt;
    DateTime? updatedAt;
    String? rememberToken;
    String? cmFirebaseToken;
    String? deviceToken;
    String? temporaryToken;
    List<dynamic>? translations;

    HelpListProviderModel({
        this.id,
        this.districtId,
        this.meghalaId,
        this.unitId,
        this.districtName,
        this.meghalaName,
        this.unitName,
        this.name,
        this.username,
        this.password,
        this.nomineeName,
        this.akpaId,
        this.mobile,
        this.upiId,
        this.image,
        this.dateOfBirth,
        this.age,
        this.joinYear,
        this.lastRenewedDate,
        this.accountAmount,
        this.balanceAmount,
        this.lastDeathId,
        this.previousDeathId,
        this.dateOfDeath,
        this.chequeNumber,
        this.creditedDate,
        this.creditedAmount,
        this.helpImage,
        this.creditedStatus,
        this.status,
        this.deathStatus,
        this.createdAt,
        this.updatedAt,
        this.rememberToken,
        this.cmFirebaseToken,
        this.deviceToken,
        this.temporaryToken,
        this.translations,
    });

    factory HelpListProviderModel.fromJson(Map<String, dynamic> json) => HelpListProviderModel(
        id: json["id"],
        districtId: json["district_id"],
        meghalaId: json["meghala_id"],
        unitId: json["unit_id"],
        districtName: json["district_name"],
        meghalaName: json["meghala_name"],
        unitName: json["unit_name"],
        name: json["name"],
        username: json["username"],
        password: json["password"],
        nomineeName: json["nominee_name"],
        akpaId: json["akpa_id"],
        mobile: json["mobile"],
        upiId: json["upi_id"],
        image: json["image"],
        dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
        age: json["age"],
        joinYear: json["join_year"],
        lastRenewedDate: json["last_renewed_date"],
        accountAmount: json["account_amount"],
        balanceAmount: json["balance_amount"],
        lastDeathId: json["last_death_id"],
        previousDeathId: json["previous_death_id"],
        dateOfDeath: json["date_of_death"] == null ? null : DateTime.parse(json["date_of_death"]),
        chequeNumber: json["cheque_number"],
        creditedDate: json["credited_date"] == null ? null : DateTime.parse(json["credited_date"]),
        creditedAmount: json["credited_amount"],
        helpImage: json["help_image"],
        creditedStatus: json["credited_status"],
        status: json["status"],
        deathStatus: json["death_status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        rememberToken: json["remember_token"],
        cmFirebaseToken: json["cm_firebase_token"],
        deviceToken: json["device_token"],
        temporaryToken: json["temporary_token"],
        translations: json["translations"] == null ? [] : List<dynamic>.from(json["translations"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "district_id": districtId,
        "meghala_id": meghalaId,
        "unit_id": unitId,
        "district_name": districtName,
        "meghala_name": meghalaName,
        "unit_name": unitName,
        "name": name,
        "username": username,
        "password": password,
        "nominee_name": nomineeName,
        "akpa_id": akpaId,
        "mobile": mobile,
        "upi_id": upiId,
        "image": image,
        "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "age": age,
        "join_year": joinYear,
        "last_renewed_date": lastRenewedDate,
        "account_amount": accountAmount,
        "balance_amount": balanceAmount,
        "last_death_id": lastDeathId,
        "previous_death_id": previousDeathId,
        "date_of_death": "${dateOfDeath!.year.toString().padLeft(4, '0')}-${dateOfDeath!.month.toString().padLeft(2, '0')}-${dateOfDeath!.day.toString().padLeft(2, '0')}",
        "cheque_number": chequeNumber,
        "credited_date": "${creditedDate!.year.toString().padLeft(4, '0')}-${creditedDate!.month.toString().padLeft(2, '0')}-${creditedDate!.day.toString().padLeft(2, '0')}",
        "credited_amount": creditedAmount,
        "help_image": helpImage,
        "credited_status": creditedStatus,
        "status": status,
        "death_status": deathStatus,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
        "remember_token": rememberToken,
        "cm_firebase_token": cmFirebaseToken,
        "device_token": deviceToken,
        "temporary_token": temporaryToken,
        "translations": translations == null ? [] : List<dynamic>.from(translations!.map((x) => x)),
    };
}
