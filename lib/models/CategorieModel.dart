class Category {
  final String id; // L'identifiant unique de la catégorie
  final String name; // Le nom de la catégorie
  final String description; // La description de la catégorie

  // Constructeur de la classe Category
  Category({
    required this.id,
    required this.name,
    required this.description,
  });

  // Méthode pour convertir l'objet Category en Map (pour Firestore ou autres)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  // Méthode pour créer un objet Category à partir d'un Map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] ?? '', // Si 'id' est null, on renvoie une chaîne vide
      name: map['name'] ?? '', // Si 'name' est null, on renvoie une chaîne vide
      description: map['description'] ?? '', // Si 'description' est null, on renvoie une chaîne vide
    );
  }
}
