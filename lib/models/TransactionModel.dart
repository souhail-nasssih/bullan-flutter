import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String title;
  final double prix;
  final String type; // 'dépense' ou 'recette'
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.title,
    required this.prix,
    required this.type,
    required this.date,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map, String id) {
    return TransactionModel(
      id: id,
      title: map['title'],
      prix: map['amount'].toDouble(),
      type: map['type'],
      date: (map['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': prix,
      'type': type,
      'date': date,
    };
  }
}
