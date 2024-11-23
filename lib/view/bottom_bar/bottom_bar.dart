// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lifelinekerala/view/dashboard/dashboard.dart';
import 'package:lifelinekerala/view/help_provided_list/help_provided_list.dart';
import 'package:lifelinekerala/view/home_screen/home.dart';
import 'package:lifelinekerala/view/profile_screen/profile.dart';
import 'package:lifelinekerala/view/transaction/transaction.dart';

class BottombarScreens extends StatefulWidget {
  const BottombarScreens({super.key});

  @override
  __BottombarScreensState createState() => __BottombarScreensState();
}

class __BottombarScreensState extends State<BottombarScreens> {
  int _currentPageIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const DashBoardScreen(),
    const TransactionScreen(),
    const HelpProvidedList(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: _currentPageIndex,
            onTap: (int index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            items: [
              buildBottomNavigationBarItem(
                  imagePath: 'assets/home.png', index: 0, label: 'Home'),
              buildBottomNavigationBarItem(
                  imagePath: 'assets/dashboardicon.png',
                  index: 1,
                  label: 'Dashboard'),
              buildBottomNavigationBarItem(
                  imagePath: 'assets/transactionicon.png',
                  index: 2,
                  label: 'Transaction'),
              buildBottomNavigationBarItem(
                  imagePath: 'assets/helpprovided.png',
                  index: 3,
                  label: 'Help Provided '),
              buildBottomNavigationBarItem(
                  imagePath: 'assets/user.png', index: 4, label: 'Profile'),
            ],
          ),
        ),
      ),
      body: _pages[_currentPageIndex],
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(
      {required String imagePath, required int index, required String label}) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPageIndex == index
                ? Colors.blue.shade50
                : Colors.transparent,
          ),
          padding: const EdgeInsets.all(10),
          child: ImageIcon(
            AssetImage(imagePath),
            color: Colors.blue,
          ),
        ),
      ),
      label: label,
    );
  }
}
