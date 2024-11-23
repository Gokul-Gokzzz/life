class MemberDetails {
  final int id;
  final int districtId;
  final String districtName;
  final String lifelineId;
  final String name;
  final String username;
  final String password;
  final String mobile;
  final String email;
  final String upiId;
  final String accountNumber;
  final String ifscCode;
  final String image;
  final String signature;
  final String dateOfBirth;
  final String place;
  final String address;
  final String otherDocumentDetails;
  final String aadhaarNumber;
  final int accountAmount;
  final int status;
  final int terms;
  final String createdAt;
  final String updatedAt;
  final String rememberToken;
  final String cmFirebaseToken;
  final String deviceToken;
  final String temporaryToken;

  MemberDetails({
    required this.id,
    required this.districtId,
    required this.districtName,
    required this.lifelineId,
    required this.name,
    required this.username,
    required this.password,
    required this.mobile,
    required this.email,
    required this.upiId,
    required this.accountNumber,
    required this.ifscCode,
    required this.image,
    required this.signature,
    required this.dateOfBirth,
    required this.place,
    required this.address,
    required this.otherDocumentDetails,
    required this.aadhaarNumber,
    required this.accountAmount,
    required this.status,
    required this.terms,
    required this.createdAt,
    required this.updatedAt,
    required this.rememberToken,
    required this.cmFirebaseToken,
    required this.deviceToken,
    required this.temporaryToken,
  });
  factory MemberDetails.fromJson(Map<String, dynamic> json) {
    return MemberDetails(
      id: json['id'],
      districtId: json['district_id'] ?? 0,
      districtName: json['district_name'] ?? '',
      lifelineId: json['lifeline_id'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      upiId: json['upi_id'] ?? '',
      accountNumber: json['account_number'] ?? '',
      ifscCode: json['ifsc_code'] ?? '',
      image: json['image'] ?? '',
      signature: json['signature'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      place: json['place'] ?? '',
      address: json['address'] ?? '',
      otherDocumentDetails: json['other_document_details'] ?? '',
      aadhaarNumber: json['aadhaar_number'] ?? '',
      accountAmount: json['account_amount'] ?? 0,
      status: json['status'] ?? 0,
      terms: json['terms'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      rememberToken: json['remember_token'] ?? '',
      cmFirebaseToken: json['cm_firebase_token'] ?? '',
      deviceToken: json['device_token'] ?? '',
      temporaryToken: json['temporary_token'] ?? '',
    );
  }
}

class FamilyDetails {
  final int id;
  final int isHead;
  final int memberId;
  final String name;
  final String relation;
  final String phone;
  final String email;
  final String aadhaarNumber;
  final String dob;

  FamilyDetails({
    required this.id,
    required this.isHead,
    required this.memberId,
    required this.name,
    required this.relation,
    required this.phone,
    required this.email,
    required this.aadhaarNumber,
    required this.dob,
  });

  factory FamilyDetails.fromJson(Map<String, dynamic> json) {
    return FamilyDetails(
      id: json['id'],
      isHead: json['is_head'],
      memberId: json['member_id'],
      name: json['name'],
      relation: json['relation'],
      phone: json['phone'],
      email: json['email'],
      aadhaarNumber: json['adhaar_number'],
      dob: json['dob'],
    );
  }
}

class HelpReceived {
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

  HelpReceived({
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
  });

  factory HelpReceived.fromJson(Map<String, dynamic> json) {
    return HelpReceived(
      id: json['id'],
      memberId: json['member_id'],
      memberFamilyId: json['member_family_id'],
      helpType: json['help_type'],
      incidentDate: json['incident_date'],
      creditedDate: json['credited_date'],
      creditedAmount: json['credited_amount'],
      chequeNumber: json['cheque_number'] ?? '',
      otherRefNumber: json['other_ref_number'] ?? '',
      helpImage: json['help_image'] ?? '',
      familyMemberName: json['family_member_name'],
    );
  }
}
