import 'package:flutter/material.dart';
import 'package:bullan/models/TransactionModel.dart';

class TransactionHistoryPage extends StatelessWidget {
  final Stream<List<TransactionModel>> stream;

  const TransactionHistoryPage({
    required this.stream,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TransactionModel>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Aucune transaction trouvée.'));
        } else {
          List<TransactionModel> transactions = snapshot.data!;
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(
                    transaction.type == 'dépense'
                        ? Icons.remove_circle
                        : Icons.add_circle,
                    color: transaction.type == 'dépense'
                        ? Colors.red
                        : Colors.green,
                  ),
                  title: Text(transaction.type),
                  subtitle: Text(transaction.title),
                  trailing: Text('${transaction.prix} MAD'),
                ),
              );
            },
          );
        }
      },
    );
  }
}
