import 'package:bullan/utils/CustomAppBar.dart';
import 'package:bullan/widgets/CustomButton.dart';
import 'package:bullan/widgets/CustomInputField.dart';
import 'package:flutter/material.dart';

class AddCategorie extends StatefulWidget {
  const AddCategorie({super.key});

  @override
  State<AddCategorie> createState() => _AddCategorieState();
}

class _AddCategorieState extends State<AddCategorie> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Ajouter une catégorie'),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 500, // Optionnel : limite la largeur sur grand écran
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Icon(
                      Icons.category,
                      size: 80,
                      color: Color(
                          0xFF6D0EB5), // Même couleur que le thème pour la cohérence
                    ),

                    const SizedBox(
                        height: 80), // Pour centrer mieux visuellement
                    CustomInputField(
                      controller: _nameController,
                      labelText: 'Nom catégorie',
                      hintText: 'Entrez votre nom de catégorie',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un nom de catégorie';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      controller: _descriptionController,
                      labelText: 'discription',
                      hintText: 'Entrez votre discription',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un discription';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'Enregistrer',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Action à faire après validation
                          print(
                              "Nom category: ${_nameController.text}, discription: ${_descriptionController.text}");
                        }
                      },
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
