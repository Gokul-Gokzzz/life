import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lifelinekerala/model/helpmodel/help_model.dart';
import 'package:lifelinekerala/model/confgmodel/config_model.dart';
import 'package:lifelinekerala/service/api_service.dart';
import 'widget/help.dart';

class HelpReceivedScreen extends StatefulWidget {
  const HelpReceivedScreen({super.key});

  @override
  State<HelpReceivedScreen> createState() => _HelpReceivedScreenState();
}

class _HelpReceivedScreenState extends State<HelpReceivedScreen> {
  late Future<List<HelpModel>> helpReceivedList;
  late Future<Config> config;
  List<HelpModel>? _filteredHelpReceivedList;
  List<HelpModel>? _allHelpReceivedList;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    config = ApiService().getConfig();
    helpReceivedList = ApiService().getHelpReceivedList();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _filteredHelpReceivedList = _filterHelpReceivedList(
        _searchController.text,
      );
    });
  }

  List<HelpModel>? _filterHelpReceivedList(String query) {
    if (query.isEmpty) {
      return _allHelpReceivedList;
    }
    return _allHelpReceivedList
        ?.where((help) =>
            help.familyMemberName.toLowerCase().contains(query.toLowerCase()) ||
            help.helpType.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
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
                        controller: _searchController,
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
                            child: const Icon(Icons.search, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 50),
              const Text(
                'Help Received List',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<HelpModel>>(
                  future: helpReceivedList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      log('Error: ${snapshot.error}');
                      return const Center(
                          child: Text('Failed to load help list'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      log('No data: ${snapshot.data}');
                      return const Center(
                          child: Text('No help records available'));
                    } else {
                      log('Data received: ${snapshot.data}');
                      final helpList = snapshot.data!;
                      _allHelpReceivedList =
                          helpList; // Update allHelpReceivedList
                      _filteredHelpReceivedList = _filterHelpReceivedList(
                        _searchController.text,
                      );
                      return FutureBuilder<Config>(
                        future: config,
                        builder: (context, configSnapshot) {
                          if (configSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (configSnapshot.hasError) {
                            log('Error fetching config: ${configSnapshot.error}');
                            return const Center(
                                child: Text('Failed to load configuration'));
                          } else if (!configSnapshot.hasData) {
                            return const Center(
                                child: Text('No configuration data available'));
                          } else {
                            final configData = configSnapshot.data!;
                            return ListView.builder(
                              itemCount: _filteredHelpReceivedList!.length,
                              itemBuilder: (context, index) {
                                final help = _filteredHelpReceivedList![index];
                                final imageUrl =
                                    '${configData.baseUrls.customerImageUrl}/${help.imagePath}'; // Append the specific image path to the base URL
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Image.network(
                                                imageUrl,
                                                height: 80,
                                                width: 80,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Icon(
                                                      Icons.person,
                                                      size: 80,
                                                      color: Colors.grey);
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Family Member Name',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  help.familyMemberName,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        InfoRow(
                                            title: 'Help Type',
                                            value: help.helpType),
                                        InfoRow(
                                            title: 'Incident Date',
                                            value: help.incidentDate),
                                        InfoRow(
                                            title: 'Cheque Number',
                                            value: help.chequeNumber),
                                        InfoRow(
                                            title: 'Credited Date',
                                            value: help.creditedDate),
                                        InfoRow(
                                            title: 'Credited Amount',
                                            value: help.creditedAmount),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
