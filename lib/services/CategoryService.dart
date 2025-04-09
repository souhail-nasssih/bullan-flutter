import 'package:bullan/models/CategorieModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

static Future<List<Category>> getCategories() async {
  final snapshot = await FirebaseFirestore.instance.collection('categories').get();
  return snapshot.docs
      .map((doc) => Category.fromMap({
            ...doc.data(),
            'id': doc.id,
          }))
      .toList();
}


  // Ajouter une nouvelle catégorie
  Future<void> addCategory(Category category) async {
    try {
      await _db.collection('categories').add(category.toMap());
    } catch (e) {
      print("Erreur lors de l'ajout de la catégorie: $e");
    }
  }

  // Modifier une catégorie existante
  Future<void> updateCategory(Category category) async {
    try {
      await _db.collection('categories').doc(category.id).update(category.toMap());
    } catch (e) {
      print("Erreur lors de la mise à jour de la catégorie: $e");
    }
  }

  // Supprimer une catégorie
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _db.collection('categories').doc(categoryId).delete();
    } catch (e) {
      print("Erreur lors de la suppression de la catégorie: $e");
    }
  }
}
