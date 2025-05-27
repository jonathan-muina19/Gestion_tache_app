// Importe le BLoC (Business Logic Component) responsable de la gestion de l'état de la liste de tâches.
import 'package:app_test/task_list/bloc/todo_bloc.dart';
// Importe les événements que le BLoC peut recevoir, comme RemoveTodo.
import 'package:app_test/task_list/bloc/todo_events.dart';
// Importe les widgets et outils de base de Flutter pour la construction de l'interface utilisateur.
import 'package:flutter/material.dart';
// Importe les widgets spécifiques à Flutter pour l'intégration avec le pattern BLoC.
import 'package:flutter_bloc/flutter_bloc.dart';

/// Un widget qui représente un élément individuel dans une liste de tâches.
///
/// Ce widget affiche le titre et le sous-titre d'une tâche,
/// et fournit un bouton pour supprimer la tâche via une boîte de dialogue de confirmation.
class Todotile extends StatelessWidget {
  /// Le titre de la tâche à afficher.
  final String title;
  /// Le sous-titre ou la description de la tâche.
  final String subtitle;
  /// L'index de cette tâche dans la liste, utilisé pour l'identifier lors de la suppression.
  final int index;
  // Fonctionnalité d'ajout ou d'édition potentielle, non implémentée actuellement.
  // final Function()? add;

  /// Construit un widget [Todotile].
  ///
  /// Nécessite un [title], un [subtitle], et un [index].
  Todotile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.index
  });

  /// Affiche une boîte de dialogue pour demander confirmation à l'utilisateur
  /// avant de supprimer une tâche.
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Supprimer cette tâche ?'),
        content: const Text('Cette action est irréversible.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext), // Annuler la suppression
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              // Envoie un événement RemoveTodo au TodoBloc pour supprimer la tâche.
              context.read<TodoBloc>().add(RemoveTodo(index));
              Navigator.pop(dialogContext); // Ferme la boîte de dialogue après suppression.
            },
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Utilise un ListTile pour afficher les informations de la tâche de manière structurée.
    return ListTile(
      // leading: Icon(Icons.person), // Icône de début de ligne, actuellement commentée.
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      subtitle: Text(subtitle),
      // Affiche les actions possibles à la fin de la tuile.
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // S'assure que le Row prend le minimum d'espace.
        children: [
          // Bouton icône pour supprimer la tâche.
          IconButton(
            onPressed: () {
              // Affiche la boîte de dialogue de confirmation avant suppression.
              _showDeleteConfirmation(context);
            },
            icon: Icon(Icons.delete, color: Colors.red), // Icône de poubelle en rouge.
          ),
        ],
      ),
      isThreeLine: false, // Indique que la tuile n'est pas configurée pour trois lignes.
      tileColor: Colors.white, // Couleur de fond de la tuile.
      dense: false, // La tuile n'est pas en mode compact.
      enabled: true, // La tuile est interactive.
      selected: true, // Indique que la tuile est visuellement sélectionnée (peut être dynamique).
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Rembourrage interne.
      // selectedColor: Colors.grey, // Couleur de sélection alternative, actuellement commentée.
      selectedTileColor: Colors.deepPurple.shade100, // Couleur de fond lorsque la tuile est sélectionnée.
      // Définit la forme de la tuile avec des coins arrondis.
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}