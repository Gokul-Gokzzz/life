class Transaction {
  final int id;
  final String date;
  final String upiId;
  final String referenceNumber;
  final String amount;
  final String createdAt;
  final String updatedAt;

  Transaction({
    required this.id,
    required this.date,
    required this.upiId,
    required this.referenceNumber,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      date: json['date'] ?? '',
      upiId: json['upi_id'] ?? '',
      referenceNumber: json['reference_number'] ?? '',
      amount: json['amount'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
