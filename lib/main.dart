import 'package:flutter/material.dart';
import 'package:lifelinekerala/view/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lifelinekerala/view/bottom_bar/bottom_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkLoginStatus() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final String? username = sharedPreferences.getString('username');
    final String? password = sharedPreferences.getString('password');
    return username != null && password != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final isLoggedIn = snapshot.data ?? false;
            return isLoggedIn
                ? const BottombarScreens()
                : const WelcomeScreen();
          }
        },
      ),
    );
  }
}
