import 'package:flutter/material.dart';
import 'package:lifelinekerala/model/confgmodel/config_model.dart';
import 'package:lifelinekerala/model/usermodel/user_model.dart';
import 'package:lifelinekerala/service/api_service.dart';
import 'package:lifelinekerala/service/notification_service.dart';
import 'package:lifelinekerala/view/dashboard/dashboard.dart';
import 'package:lifelinekerala/view/help_provided_list/help_provided_list.dart';
import 'package:lifelinekerala/view/help_provided_list/help_received_list.dart';
import 'package:lifelinekerala/view/home_screen/drawer/drawer.dart';
import 'package:lifelinekerala/view/notification_screen/notifiaction.dart';
import 'package:lifelinekerala/view/transaction/transaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Config> _config;
  late Future<UserProfile> _userProfile;
  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _config = ApiService().fetchConfig();
    _userProfile = ApiService().getUserProfile();
    _loadUnreadNotificationsCount();
  }

  Future<void> _loadUnreadNotificationsCount() async {
    final count = await NotificationService().getUnreadCount('5');
    setState(() {
      _unreadCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: Future.wait([_config, _userProfile]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            }

            final config = snapshot.data![0] as Config;
            final userProfile = snapshot.data![1] as UserProfile;

            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Image.asset(
                            'assets/menus.png',
                            height: 30,
                            width: 30,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                suffixIcon: Container(
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(Icons.search,
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationScreen(),
                              ),
                            );
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Image.asset(
                                'assets/bell.png',
                                height: 25,
                                width: 25,
                              ),
                              if (_unreadCount > 0)
                                Positioned(
                                  right: -6,
                                  top: -6,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 26,
                                      minHeight: 16,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$_unreadCount',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: buildProfileImage(config, userProfile),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userProfile.name,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Text(userProfile.districtName),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'What do you want to donate today',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 30),
                    buildCard(
                      context,
                      'Dashboard',
                      'View your dashboard &\ncheck your details',
                      'assets/dashboard.png',
                      Colors.blue.shade50,
                      const Color.fromARGB(255, 3, 111, 200),
                      DashBoardScreen(),
                    ),
                    const SizedBox(height: 30),
                    buildCard(
                      context,
                      'Transactions',
                      'View your transaction & details',
                      'assets/transaction.png',
                      Colors.red.shade50,
                      const Color.fromARGB(255, 237, 111, 102),
                      TransactionScreen(),
                    ),
                    const SizedBox(height: 30),
                    buildCard(
                      context,
                      'Help Provided list',
                      'View your Help Provided list',
                      'assets/help.png',
                      Colors.teal.shade50,
                      Colors.green,
                      HelpProvidedList(),
                    ),
                    const SizedBox(height: 30),
                    buildCard(
                      context,
                      'Help Received list',
                      'View your Help Received list',
                      'assets/help.png',
                      Colors.orange.shade50,
                      Colors.orange,
                      HelpReceivedScreen(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildProfileImage(Config config, UserProfile userProfile) {
    final imageUrl = '${config.baseUrls.customerImageUrl}/${userProfile.image}';
    return Image.network(
      imageUrl,
      height: 80,
      width: 80,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.person, size: 80, color: Colors.grey);
      },
    );
  }

  Widget buildCard(BuildContext context, String title, String subtitle,
      String imagePath, Color bgColor, Color titleColor, Widget nextScreen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextScreen),
        );
      },
      child: Card(
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Image.asset(
                        'assets/right-arrow.png',
                        height: 14,
                        width: 14,
                      ),
                    ],
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: bgColor,
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
