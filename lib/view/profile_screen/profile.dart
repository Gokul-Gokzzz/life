import 'package:flutter/material.dart';
import 'package:lifelinekerala/model/confgmodel/config_model.dart';
import 'package:lifelinekerala/service/api_service.dart';
import 'package:lifelinekerala/model/usermodel/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService apiService = ApiService();
  UserProfile? _userProfile;
  Config? _config;
  bool _isLoading = true;
  bool _showFullDetails = false;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final profile = await apiService.getUserProfile();
    final config = await apiService.getConfig();
    setState(() {
      _userProfile = profile;
      _config = config;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _userProfile != null && _config != null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          buildProfileHeader(),
                          const SizedBox(height: 20),
                          buildProfileDetails(),
                        ],
                      ),
                    ),
                  )
                : const Center(child: Text('Failed to load user details')),
      ),
    );
  }

  Widget buildProfileHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: buildProfileImage(),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userProfile!.name,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(_userProfile!.districtName),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ],
    );
  }

  Widget buildProfileImage() {
    final imageUrl =
        '${_config!.baseUrls.customerImageUrl}/${_userProfile!.image}';
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

  Widget buildProfileDetails() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.blueAccent, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Personal Details',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          buildProfileDetail('Name', _userProfile!.name),
          buildProfileDetail('Lifeline ID', _userProfile!.lifelineId),
          buildProfileDetail(
              'Account Amount', _userProfile!.accountAmount.toString()),
          buildProfileDetail('Mobile', _userProfile!.mobile),
          buildProfileDetail('UPI ID', _userProfile!.upiId),
          buildProfileDetail('Place', _userProfile!.place),
          buildProfileDetail('District Name', _userProfile!.districtName),
          buildProfileDetail('Aadhaar Number', _userProfile!.aadhaarNumber),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              setState(() {
                _showFullDetails = !_showFullDetails;
              });
            },
            child: Text(
              _showFullDetails ? 'Show Less' : 'Show Full Details',
              style: const TextStyle(color: Colors.blue),
            ),
          ),
          if (_showFullDetails) _buildFullProfileDetails(),
        ],
      ),
    );
  }

  Widget buildProfileDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildFullProfileDetails() {
    final imageUrl =
        '${_config!.baseUrls.customerImageUrl}/${_userProfile!.image}';
    final signatureUrl =
        '${_config!.baseUrls.customerImageUrl}/${_userProfile!.signature}';
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.blueAccent, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildProfileDetail('Email', _userProfile!.email),
          buildProfileDetail('Address', _userProfile!.address),
          buildProfileDetail('IFSC Code', _userProfile!.ifscCode),
          buildProfileDetail('Profile Image', ''),
          Image.network(imageUrl, height: 50, width: 100),
          const SizedBox(height: 10),
          buildProfileDetail('Signature', ''),
          Image.network(signatureUrl, height: 50, width: 100),
          buildProfileDetail(
              'Other Documents', _userProfile!.otherDocumentDetails),
        ],
      ),
    );
  }
}
