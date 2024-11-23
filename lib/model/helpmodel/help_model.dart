class HelpModel {
  final int id;
  final int memberId;
  final int memberFamilyId;
  final String helpType;
  final String incidentDate;
  final String creditedDate;
  final String creditedAmount;
  final String chequeNumber;
  final String otherRefNumber;
  final String helpImage;
  final String familyMemberName;
  final String lifelineId;
  final String memberName;
  final String imagePath;

  HelpModel({
    required this.id,
    required this.memberId,
    required this.memberFamilyId,
    required this.helpType,
    required this.incidentDate,
    required this.creditedDate,
    required this.creditedAmount,
    required this.chequeNumber,
    required this.otherRefNumber,
    required this.helpImage,
    required this.familyMemberName,
    required this.lifelineId,
    required this.memberName,
    required this.imagePath,
  });

  factory HelpModel.fromJson(Map<String, dynamic> json) {
    return HelpModel(
      id: json['id'] ?? '',
      memberId: json['member_id'] ?? '',
      memberFamilyId: json['member_family_id'] ?? '',
      helpType: json['help_type'] ?? '',
      incidentDate: json['incident_date'] ?? '',
      creditedDate: json['credited_date'] ?? '',
      creditedAmount: json['credited_amount'] ?? '',
      chequeNumber: json['cheque_number'] ?? '',
      otherRefNumber: json['other_ref_number'] ?? '',
      helpImage: json['help_image'] ?? '',
      familyMemberName: json['family_member_name'] ?? '',
      lifelineId: json['lifeline_id'] ?? '',
      memberName: json['member_name'] ?? '',
      imagePath: json['image_path'] ?? '',
    );
  }
}
