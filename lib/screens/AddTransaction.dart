import 'package:bullan/models/CategorieModel.dart';
import 'package:bullan/models/TransactionModel.dart';
import 'package:bullan/services/CategoryService.dart';
import 'package:bullan/services/TransactionService.dart';
import 'package:bullan/utils/CustomAppBar.dart';
import 'package:bullan/widgets/CustomButton.dart';
import 'package:bullan/widgets/CustomInputField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  List<Category> _categories = [];
  bool _isLoading = true;

  String? _selectedCategory; // ID de la catégorie sélectionnée
  String? _transactionType; // 'recette' ou 'dépense'

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final data = await CategoryService.getCategories();
      setState(() {
        _categories = data;
        _isLoading = false;
      });
    } catch (e) {
      print("Erreur de chargement des catégories: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> saveTransaction() async {
    final transaction = TransactionModel(
      id: Timestamp.now()
          .millisecondsSinceEpoch
          .toString(), // Utilisation du timestamp comme ID
      title: _descriptionController.text.trim(),
      prix: double.parse(_priceController.text.trim()),
      type: _transactionType!,
      date: DateTime.now(),
    );

    try {
      final service = TransactionService();
      await service.addTransaction(transaction);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaction ajoutée avec succès')),
      );

      Navigator.pop(context); // Retour à la page précédente
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Ajouter une transaction'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                                .map((category) => DropdownMenuItem<String>(
                                      value: category.id,
                                      child: Text(category.name),
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
                          const SizedBox(height: 16),
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
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ),
                            ),
                          const SizedBox(height: 24),
                          CustomButton(
                            text: 'Enregistrer',
                            onPressed: () {
                              final isValid = _formKey.currentState!.validate();
                              final isTypeSelected = _transactionType != null;

                              setState(() {});

                              if (isValid && isTypeSelected) {
                                saveTransaction();
                              }
                            },
                          ),
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
