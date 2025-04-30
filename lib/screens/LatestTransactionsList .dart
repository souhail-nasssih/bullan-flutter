import 'package:flutter/material.dart';
import '../services/TransactionService.dart';
import '../widgets/TransactionCard.dart';
import '../models/TransactionModel.dart';

class LatestTransactionsList extends StatelessWidget {
  const LatestTransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<TransactionModel>>(
        stream: TransactionService().getLatestTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucune transaction récente'));
          } else {
            final transactions = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionCard(transaction: transactions[index]);
              },
            );
          }
        },
      ),
    );
  }
}
