import 'package:flutter/material.dart';
import 'package:lifelinekerala/model/usermodel/member_details.dart';
import 'package:lifelinekerala/service/api_service.dart';

class FamilyDetailsScreen extends StatefulWidget {
  @override
  _FamilyDetailsScreenState createState() => _FamilyDetailsScreenState();
}

class _FamilyDetailsScreenState extends State<FamilyDetailsScreen> {
  late Future<List<FamilyDetails>> _familyDetails;

  @override
  void initState() {
    super.initState();
    _familyDetails =
        ApiService().fetchFamilyDetails(); // Fetching family details
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Details'),
      ),
      body: FutureBuilder<List<FamilyDetails>>(
        future: _familyDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error occurred'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No family details found'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final familyMember = snapshot.data![index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Name: ${familyMember.name}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            )),
                        SizedBox(height: 8.0),
                        Text('Relation: ${familyMember.relation}'),
                        Text('Phone: ${familyMember.phone}'),
                        Text('Email: ${familyMember.email}'),
                        Text('Aadhaar Number: ${familyMember.aadhaarNumber}'),
                        Text('Date of Birth: ${familyMember.dob}'),
                        Text(
                            'Is Head: ${familyMember.isHead == 1 ? 'Yes' : 'No'}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
