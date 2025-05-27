class Todo {
  final String id;
  final String title;
  final String subtitle;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
  });

  // La methode copyWith permet de creer une copie d'un objet
  // existant avec certains champs modifies, sans toucher aux autres
  // Flutter suit une approche immutabilite
  // On ne modifie jamais un objet existant
  // A la place , on cree un nouvel objet avec les valeurs mises a jour
  Todo copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    String? subtitle,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
