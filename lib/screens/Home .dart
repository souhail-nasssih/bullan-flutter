import 'package:bullan/screens/AddTransaction.dart';
import 'package:bullan/screens/Addcategorie.dart';
import 'package:bullan/screens/History.dart';
import 'package:bullan/widgets/AddItemsCategorie.dart';
import 'package:bullan/widgets/HomeMenuCard.dart';
import 'package:bullan/widgets/UserInfoCard.dart';
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
      // AppBar avec dégradé
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
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
          title: const Text(
            'Home Page',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),

      // Body centralisé avec beaux widgets
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Remplace le Column dans le body par ceci :
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const UserInfoCard(
                  name: 'Jean Dupont',
                  email: 'jean.dupont@email.com',
                ),
                const SizedBox(height: 12),
                const BalanceCard(
                    label: 'Votre solde', balance: '250 000 FCFA'),
                const SizedBox(height: 24),
                HomeMenuCard(
                  icon: Icons.category,
                  label: 'Categorie',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddCategorie(),
                      ),
                    );
                  },
                ),
                HomeMenuCard(
                    icon: Icons.add_circle,
                    label: 'Transaction',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddTransaction(),
                        ),
                      );
                    }),
                const SizedBox(height: 16),
                HomeMenuCard(
                  icon: Icons.history,
                  label: 'Historique',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const History(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
