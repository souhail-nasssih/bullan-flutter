import 'package:bullan/utils/CustomAppBar.dart';
import 'package:bullan/widgets/AddItemsCategorie.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
      appBar: const CustomAppBar(title: 'Historique des transactions'),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Color(0xFF6D0EB5),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF6D0EB5),
              indicatorWeight: 3,
              tabs: const [
                Tab(text: 'Tous'),
                Tab(text: 'Dépenses'),
                Tab(text: 'Recettes'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildHistoryPage('Tous les historiques'),
                _buildHistoryPage('Historique des dépenses'),
                _buildHistoryPage('Historique des recettes'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryPage(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
