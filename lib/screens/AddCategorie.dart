import 'package:bullan/models/CategorieModel.dart';
import 'package:bullan/services/CategoryService.dart';
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

  List<Category> _categories = [];
  String? _editingCategoryId;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      List<Category> data = await CategoryService.getCategories();
      setState(() {
        _categories = data;
      });
    } catch (e) {
      print("Erreur de chargement des catégories : $e");
    }
  }

  Future<void> _deleteCategory(String id) async {
    try {
      await CategoryService().deleteCategory(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Catégorie supprimée.")),
      );
      _fetchCategories(); // Refresh list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors de la suppression.")),
      );
    }
  }

  Future<void> _editCategory(Category category) async {
    setState(() {
      _nameController.text = category.name;
      _descriptionController.text = category.description;
      _editingCategoryId = category.id;
    });
  }

  Future<void> _saveCategory() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_editingCategoryId != null) {
          // Modifier une catégorie existante
          Category updatedCategory = Category(
            id: _editingCategoryId!,
            name: _nameController.text,
            description: _descriptionController.text,
          );
          await CategoryService().updateCategory(updatedCategory);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Catégorie modifiée avec succès!")),
          );
        } else {
          // Ajouter une nouvelle catégorie
          Category newCategory = Category(
            id: '',
            name: _nameController.text,
            description: _descriptionController.text,
          );
          await CategoryService().addCategory(newCategory);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Catégorie ajoutée avec succès!")),
          );
        }

        _nameController.clear();
        _descriptionController.clear();
        _editingCategoryId = null;
        _fetchCategories();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erreur lors de l'enregistrement.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Ajouter une catégorie'),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  /// 🧾 FORMULAIRE
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Icon(Icons.category,
                            size: 80, color: Color(0xFF6D0EB5)),
                        const SizedBox(height: 40),
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
                          labelText: 'Description',
                          hintText: 'Entrez une description',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer une description';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          text: _editingCategoryId == null
                              ? 'Enregistrer'
                              : 'Modifier',
                          onPressed: _saveCategory,
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),

                  /// 📋 TABLEAU DES CATÉGORIES
                  const Text(
                    "Catégories existantes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final cat = _categories[index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.label_outline),
                          title: Text(cat.name),
                          subtitle: Text(cat.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editCategory(cat),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteCategory(cat.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
