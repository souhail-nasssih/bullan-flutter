import 'package:bullan/services/TransactionService.dart';
import 'package:bullan/widgets/TransactionHistoryPage.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final service = TransactionService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Historiques',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6D0EB5),
                Color(0xFF4059F1)
              ], // Violet vers bleu
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Color.fromARGB(255, 28, 2, 48),
          unselectedLabelColor: Colors.white,
          indicatorColor: Color.fromARGB(255, 88, 11, 148),
          indicatorWeight: 3,
          tabs: const [
            Tab(
              text: 'Tous',
            ),
            Tab(text: 'Dépenses'),
            Tab(text: 'Recettes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TransactionHistoryPage(
            stream: service.getAllTransactions(),
          ),
          TransactionHistoryPage(
            stream: service.getExpenses(),
          ),
          TransactionHistoryPage(
            stream: service.getIncome(),
          ),
        ],
      ),
    );
  }
}
