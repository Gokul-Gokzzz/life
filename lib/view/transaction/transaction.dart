import 'package:flutter/material.dart';
import 'package:lifelinekerala/model/transactionmodel/transaction_model.dart';
import 'package:lifelinekerala/service/api_service.dart';
import 'widget/transaction_card.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with SingleTickerProviderStateMixin {
  late Future<List<Transaction>> _transactionList;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showQrCode = false;

  @override
  void initState() {
    super.initState();
    _transactionList = ApiService().getTransactionList();

    // Initialize the animation controller and animation
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleQrCode() {
    setState(() {
      _showQrCode = !_showQrCode;
      if (_showQrCode) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
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
              const SizedBox(height: 20),
              Text(
                'Transactions',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: FutureBuilder<List<Transaction>>(
                  future: _transactionList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      print('Error in FutureBuilder: ${snapshot.error}');
                      return Center(child: Text('Failed to load transactions'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No transactions available'));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final transaction = snapshot.data![index];
                          return TransactionCard(
                            date: transaction.date,
                            amount: transaction.amount,
                            referenceNumber: transaction.referenceNumber,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _animation.value,
                    child: Transform.scale(
                      scale: _animation.value,
                      child: _showQrCode
                          ? Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/qrcode.png',
                                    fit: BoxFit.cover,
                                    height: 200,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Place the QR code in front of the scanner.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _toggleQrCode,
          child: Icon(_showQrCode ? Icons.close : Icons.payment),
        ),
      ),
    );
  }
}
