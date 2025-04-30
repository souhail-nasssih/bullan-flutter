import 'package:bullan/screens/LatestTransactionsList%20.dart';
import 'package:bullan/services/TransactionService.dart';
import 'package:bullan/widgets/FeatureCard.dart';
import 'package:bullan/widgets/UserAndBalanceCard.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          StreamBuilder<double>(
            stream: TransactionService().getSoldeStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: CircularProgressIndicator(color: Colors.white),
                );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("Erreur: ${snapshot.error}",
                      style: const TextStyle(color: Colors.white)),
                );
              } else {
                double balance = snapshot.data ?? 0.0;
                return UserAndBalanceCard(
                  name: 'NASSIH SOUHAIL',
                  email: 'souhail@gmail.com',
                  label: 'Votre solde',
                  balance: '${balance.toStringAsFixed(2)} MAD',
                );
              }
            },
          ),
          FeatureCard(
            features: [
              FeatureItem(icon: Icons.send, label: 'Send'),
              FeatureItem(icon: Icons.qr_code, label: 'Scan'),
              FeatureItem(icon: Icons.payment, label: 'Pay'),
              FeatureItem(icon: Icons.history, label: 'History'),
            ],
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: SingleChildScrollView(
                child: LatestTransactionsList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
