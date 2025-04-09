class Category {
  final String id; 
  final String name; 
  final String description; 

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
      id: map['id'] ?? '', 
      name: map['name'] ?? '',
      description: map['description'] ?? '', 
    );
  }
}
