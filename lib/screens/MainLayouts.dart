import 'package:bullan/screens/AddCategorie.dart';
import 'package:bullan/screens/AddTransaction.dart';
import 'package:bullan/screens/History.dart';
import 'package:bullan/screens/Home%20.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    Home(),
    AddCategorie(),
    AddTransaction(),
    History(),
  ];

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Catégories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historique',
          ),
        ],
      ),
    );
  }
}







// class MainLayout extends StatefulWidget {
//   final int currentIndex;
//   final Widget body;
//   final PreferredSizeWidget? appBar;

//   const MainLayout({
//     super.key,
//     required this.currentIndex,
//     required this.body,
//     this.appBar,
//   });

//   @override
//   State<MainLayout> createState() => _MainLayoutState();
// }

// class _MainLayoutState extends State<MainLayout> {
//   late int _currentIndex = widget.currentIndex;

//   void _onTabTapped(int index) {
//     NavigationHelper.handleBottomNavTap(context, _currentIndex, index,
//         (newIndex) {
//       setState(() {
//         _currentIndex = newIndex;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: widget.appBar,
//       body: widget.body,
//       bottomNavigationBar: BottomNavBar(
//         currentIndex: widget.currentIndex,
//         onTap: _onTabTapped,
//       ),
//     );
//   }
// }
