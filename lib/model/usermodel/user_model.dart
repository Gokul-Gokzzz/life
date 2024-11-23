class UserProfile {
  final int id;
  final int districtId;
  final String districtName;
  final String lifelineId;
  final String name;
  final String username;
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
  final double accountAmount;
  final int status;
  final int terms;
  final String createdAt;
  final String updatedAt;

  UserProfile({
    required this.id,
    required this.districtId,
    required this.districtName,
    required this.lifelineId,
    required this.name,
    required this.username,
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
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      districtId: json['district_id'],
      districtName: json['district_name'],
      lifelineId: json['lifeline_id'],
      name: json['name'],
      username: json['username'],
      mobile: json['mobile'],
      email: json['email'] ?? "",
      upiId: json['upi_id'],
      accountNumber: json['account_number'] ?? "",
      ifscCode: json['ifsc_code'] ?? "",
      image: json['image'] ?? "",
      signature: json['signature'] ?? "",
      dateOfBirth: json['date_of_birth'],
      place: json['place'],
      address: json['address'],
      otherDocumentDetails: json['other_document_details'],
      aadhaarNumber: json['aadhaar_number'],
      accountAmount: (json['account_amount'] as num).toDouble(),
      status: json['status'],
      terms: json['terms'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
