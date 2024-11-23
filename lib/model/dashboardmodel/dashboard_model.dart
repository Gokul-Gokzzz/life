import 'package:lifelinekerala/model/usermodel/member_details.dart';

class DashBoardModel {
  bool? status;
  String? message;
  MemberDetails? memberDetails;

  DashBoardModel({this.status, this.message, this.memberDetails});

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    memberDetails = json['member_details'] != null
        ? MemberDetails.fromJson(json['member_details'])
        : null;
  }

  Map<String, dynamic> toJson(data) {
    data['status'] = status;
    data['message'] = message;

    data['member_details'] = memberDetails;

    return data;
  }
}
