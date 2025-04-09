import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  final String name;
  final String email;

  const UserInfoCard({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), 
        gradient: const LinearGradient(
          colors: [Color(0xFF6D0EB5), Color(0xFF4059F1)], 
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar simple, rond et bien stylisé
          const CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white24,
            child: const Icon(Icons.person, color: Colors.white, size: 35),
          ),
          const SizedBox(width: 20),
          // Colonne pour le nom et l'email
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                  height: 6), 
              Text(
                email,
                style: const TextStyle(
                    fontSize: 16, 
                    color: Colors.white70,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
