import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lifelinekerala/model/usermodel/member_details.dart';
import 'package:lifelinekerala/service/api_service.dart';

class MemberListScreen extends StatefulWidget {
  @override
  _MemberListScreenState createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  late Future<MemberDetails> _memberDetails;

  @override
  void initState() {
    super.initState();
    _memberDetails = ApiService().fetchMemberDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Details'),
      ),
      body: FutureBuilder<MemberDetails>(
        future: _memberDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            log('Error fetching member details: ${snapshot.error}'); // Log the error
            return const Center(child: Text('Error occurred'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No member details found'));
          } else {
            final member = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        member.image.isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(member.image),
                                radius: 40,
                              )
                            : const CircleAvatar(
                                child: Icon(Icons.person, size: 40),
                                radius: 40,
                              ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                member.username,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    buildDetailTile('District Name', member.districtName),
                    buildDetailTile('Lifeline ID', member.lifelineId),
                    buildDetailTile('Mobile', member.mobile),
                    buildDetailTile('Email', member.email),
                    buildDetailTile('UPI ID', member.upiId),
                    buildDetailTile('Account Number', member.accountNumber),
                    buildDetailTile('IFSC Code', member.ifscCode),
                    buildDetailTile('Signature', member.signature),
                    buildDetailTile('Date of Birth', member.dateOfBirth),
                    buildDetailTile('Place', member.place),
                    buildDetailTile('Address', member.address),
                    buildDetailTile(
                        'Other Document Details', member.otherDocumentDetails),
                    buildDetailTile('Aadhaar Number', member.aadhaarNumber),
                    buildDetailTile(
                        'Account Amount', member.accountAmount.toString()),
                    buildDetailTile('Status', member.status.toString()),
                    buildDetailTile('Terms', member.terms.toString()),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildDetailTile(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(content),
          ),
        ],
      ),
    );
  }
}
