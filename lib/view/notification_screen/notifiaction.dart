import 'package:flutter/material.dart';
import 'package:lifelinekerala/model/notificationmodel/notification_model.dart';
import 'package:lifelinekerala/service/notification_service.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationModel>> _notifications;
  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _notifications = Future.value([]);
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final notifications = await NotificationService().fetchNotifications('5');
    setState(() {
      _notifications = Future.value(notifications);
      _unreadCount = notifications!.where((n) => n.isSeen == 0).length;
    });
  }

  void _markAsSeen(String notificationId) async {
    final bool response =
        await NotificationService().markAsSeen(notificationId);
    if (response) {
      setState(() {
        _notifications = _notifications.then((notifications) {
          return notifications.map((n) {
            if (n.id.toString() == notificationId) {
              n.isSeen = 1;
              _unreadCount--;
            }
            return n;
          }).toList();
        });
      });
    } else {
      print('Failed to mark notification as seen');
    }
  }

  void _clearAllNotifications() async {
    await NotificationService().clearAllNotifications();
    _loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
              if (_unreadCount > 0)
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Center(
                      child: Text(
                        '$_unreadCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: _clearAllNotifications,
          ),
        ],
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: _notifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notifications available.'));
          }

          final notifications = snapshot.data!;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final textColor = notification.type == "SUCCESS"
                  ? Colors.green
                  : notification.type == "ERROR"
                      ? Colors.red
                      : Colors.grey;

              return ListTile(
                title: Text(
                  notification.description,
                  style: TextStyle(
                    color: notification.isSeen == 1
                        ? textColor.withOpacity(
                            0.5) // Dimmed color for seen notifications
                        : textColor, // Full color for unseen notifications
                  ),
                ),
                onTap: () {
                  if (notification.isSeen == 0) {
                    _markAsSeen(notification.id.toString());
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
