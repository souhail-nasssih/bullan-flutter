import 'package:bullan/screens/AddCategorie.dart';
import 'package:bullan/screens/AddTransaction.dart';
import 'package:bullan/screens/History.dart';
import 'package:bullan/screens/Home%20.dart';
import 'package:flutter/material.dart';

class NavigationHelper {
  static void handleBottomNavTap(BuildContext context, int currentIndex,
      int newIndex, Function(int) updateIndex) {
    if (currentIndex == newIndex) return;

    switch (newIndex) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AddCategorie()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AddTransaction()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const History()),
        );
        break;
    }

    updateIndex(newIndex);
  }
}
