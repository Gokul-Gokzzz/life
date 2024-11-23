import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:lifelinekerala/model/notificationmodel/notification_model.dart';

class NotificationService {
  final Dio _dio = Dio();
  final String _url =
      'https://lifelinekeralatrust.com/api/v1/user/get_notifications';

  Future<List<NotificationModel>?> fetchNotifications(String memberId) async {
    try {
      final response = await _dio.post(
        _url,
        data: {'member_id': memberId},
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List?;
        if (data != null && data.isNotEmpty) {
          return data.map((json) => NotificationModel.fromJson(json)).toList();
        }
        return [];
      }
      return [];
    } catch (e) {
      print('Error fetching notifications: $e');
      return [];
    }
  }

  Future<bool> markAsSeen(String notificationId) async {
    try {
      final response = await _dio.post(
        'https://lifelinekeralatrust.com/api/v1/user/notifications_seen',
        data: {
          'notification_id': notificationId,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error marking notification as seen: $e');
      return false;
    }
  }

  Future<void> clearAllNotifications() async {
    try {
      final response = await _dio.post(
        'https://lifelinekeralatrust.com/api/v1/user/notifications_clear_all',
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        log('All notifications cleared successfully.');
      } else {
        log('Failed to clear all notifications. Status code: ${response.statusCode}');
        log('Response: ${response.data}');
      }
    } catch (e) {
      log('Error clearing all notifications: $e');
    }
  }

  Future<int> getUnreadCount(String memberId) async {
    try {
      final notifications = await fetchNotifications(memberId);
      return notifications?.where((n) => n.isSeen == 0).length ?? 0;
    } catch (e) {
      log('Error fetching unread count: $e');
      return 0;
    }
  }
}
