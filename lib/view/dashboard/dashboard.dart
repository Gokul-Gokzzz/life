// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:lifelinekerala/model/usermodel/user_model.dart';
import 'package:lifelinekerala/service/api_service.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final ApiService _apiService = ApiService();
  UserProfile? _userProfile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final profile = await _apiService.getUserProfile();
      setState(() {
        _userProfile = profile;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _userProfile != null
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                      suffixIcon: Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Icon(Icons.search,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const SizedBox(width: 5),
                            ],
                          ),
                          const SizedBox(height: 50),
                          const Text(
                            'DashBoard',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          const SizedBox(height: 30),
                          buildProfileDetails(),
                        ],
                      ),
                    ),
                  )
                : const Center(child: Text('Failed to load user profile')),
      ),
    );
  }

  Widget buildProfileDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Name',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text(_userProfile!.name,
                          style: const TextStyle(fontSize: 18.0)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Lifeline ID',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text(_userProfile!.lifelineId,
                          style: const TextStyle(fontSize: 18.0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Center(
          child: Column(
            children: [
              const Text('Account Balance',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              Text(_userProfile!.accountAmount.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 28.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Account Number',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text(
                          _userProfile!.accountNumber.isNotEmpty
                              ? _userProfile!.accountNumber
                              : 'N/A',
                          style: const TextStyle(fontSize: 18.0)),
                      const SizedBox(height: 8.0),
                      const Text('UPI ID',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text(_userProfile!.upiId,
                          style: const TextStyle(fontSize: 18.0)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('IFSC Code',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text(
                          _userProfile!.ifscCode.isNotEmpty
                              ? _userProfile!.ifscCode
                              : 'N/A',
                          style: const TextStyle(fontSize: 18.0)),
                      const SizedBox(height: 8.0),
                      const Text('Aadhaar Number',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text(_userProfile!.aadhaarNumber,
                          style: const TextStyle(fontSize: 18.0)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Mobile Number',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                          Text(_userProfile!.mobile,
                              style: const TextStyle(fontSize: 18.0)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Email ID',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                          Text(
                              _userProfile!.email.isNotEmpty
                                  ? _userProfile!.email
                                  : 'N/A',
                              style: const TextStyle(
                                  fontSize: 13.0, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('District',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                          Text(_userProfile!.districtName,
                              style: const TextStyle(fontSize: 18.0)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Place',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                          Text(_userProfile!.place,
                              style: const TextStyle(fontSize: 18.0)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Address',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                          Text(_userProfile!.address,
                              style: const TextStyle(fontSize: 18.0)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
