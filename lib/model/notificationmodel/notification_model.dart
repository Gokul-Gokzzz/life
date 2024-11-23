class NotificationModel {
  final int id;
  final int memberId;
  final String type;
  final String description;
  int isSeen;

  NotificationModel({
    required this.id,
    required this.memberId,
    required this.type,
    required this.description,
    required this.isSeen,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      memberId: json['member_id'],
      type: json['type'],
      description: json['description'],
      isSeen: json['is_seen'],
    );
  }
}
