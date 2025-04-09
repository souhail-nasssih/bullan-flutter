import 'package:bullan/utils/CustomAppBar.dart';
import 'package:bullan/widgets/CustomButton.dart';
import 'package:bullan/widgets/CustomInputField.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String? _selectedCategory;
  String? _transactionType; // 'recette' ou 'dépense'

  final List<String> _categories = [
    'Nourriture',
    'Transport',
    'Logement',
    'Divertissement'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Ajouter une transaction'),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Icon(Icons.swap_horiz,
                        size: 80, color: Color(0xFF6D0EB5)),
                    const SizedBox(height: 40),

                    /// 📂 Sélecteur de catégorie
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        labelText: 'Catégorie',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      hint: const Text('Sélectionnez une catégorie'),
                      items: _categories
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      validator: (value) => value == null
                          ? 'Veuillez sélectionner une catégorie'
                          : null,
                    ),

                    const SizedBox(height: 16),

                    /// ✍🏼 Description
                    CustomInputField(
                      controller: _descriptionController,
                      labelText: 'Description',
                      hintText: 'Entrez une description',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer une description';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    /// 💰 Prix
                    CustomInputField(
                      controller: _priceController,
                      labelText: 'Prix',
                      hintText: 'Entrez le prix',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer le prix';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Le prix doit être un nombre valide';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    /// 🧾 Type de transaction (recette ou dépense)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Type de transaction",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Recette'),
                            value: 'recette',
                            groupValue: _transactionType,
                            onChanged: (value) {
                              setState(() => _transactionType = value);
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Dépense'),
                            value: 'dépense',
                            groupValue: _transactionType,
                            onChanged: (value) {
                              setState(() => _transactionType = value);
                            },
                          ),
                        ),
                      ],
                    ),
                    if (_transactionType == null)
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.0, top: 4.0),
                          child: Text(
                            "Veuillez sélectionner un type de transaction",
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      ),

                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'Enregistrer',
                      onPressed: () {
                        final isValid = _formKey.currentState!.validate();
                        final isTypeSelected = _transactionType != null;

                        setState(
                            () {}); // Pour afficher le message d’erreur du type

                        if (isValid && isTypeSelected) {
                          print('Type       : $_transactionType');
                          print('Catégorie  : $_selectedCategory');
                          print('Description: ${_descriptionController.text}');
                          print('Prix       : ${_priceController.text}');
                          // Tu peux ici envoyer à Firebase ou autre base
                        }
                      },
                    ),
                    const SizedBox(height: 60),
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
