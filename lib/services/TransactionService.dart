import 'package:bullan/models/TransactionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Constructeur avec l'ID de l'utilisateur
  TransactionService();

  // Méthode pour ajouter une transaction
  Future<void> addTransaction(TransactionModel transaction) async {
    final balanceRef = _db
        .collection('users')
        .doc('user_id_statique')
        .collection('balance')
        .doc('main');
    final transactionRef = _db
        .collection('users')
        .doc('user_id_statique')
        .collection('transactions')
        .doc();

    return _db.runTransaction((txn) async {
      // Récupérer le solde actuel
      final balanceSnap = await txn.get(balanceRef);
      double currentSolde =
          balanceSnap.exists ? balanceSnap.data()!['solde'].toDouble() : 0.0;

      // Calculer le nouveau solde
      double newSolde;
      if (transaction.type == 'dépense') {
        newSolde = currentSolde - transaction.prix;
      } else if (transaction.type == 'recette') {
        newSolde = currentSolde + transaction.prix;
      } else {
        throw Exception('Type de transaction inconnu');
      }

      // Ajouter la transaction
      txn.set(transactionRef, transaction.toMap());

      // Mettre à jour le solde
      txn.set(balanceRef, {'solde': newSolde});
    });
  }

  // Méthode pour récupérer le solde en temps réel
  Stream<double> getSoldeStream() {
    final balanceRef = _db
        .collection('users')
        .doc('user_id_statique')
        .collection('balance')
        .doc('main');
    return balanceRef.snapshots().map((snapshot) {
      return snapshot.exists ? snapshot.data()!['solde'].toDouble() : 0.0;
    });
  }

  // Méthode pour récupérer toutes les transactions
  Stream<List<TransactionModel>> getAllTransactions() {
    return _db
        .collection('users')
        .doc('user_id_statique')
        .collection('transactions')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TransactionModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Méthode pour récupérer les transactions de type 'dépense'
  Stream<List<TransactionModel>> getExpenses() {
    return _db
        .collection('users')
        .doc('user_id_statique')
        .collection('transactions')
        .where('type', isEqualTo: 'dépense')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TransactionModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Méthode pour récupérer les transactions de type 'recette'
  Stream<List<TransactionModel>> getIncome() {
    return _db
        .collection('users')
        .doc('user_id_statique')
        .collection('transactions')
        .where('type', isEqualTo: 'recette')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TransactionModel.fromMap(doc.data(), doc.id))
            .toList());
  }
}
