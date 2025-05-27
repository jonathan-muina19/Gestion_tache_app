import 'package:flutter_bloc/flutter_bloc.dart';
// Importe Uuid pour générer des identifiants uniques, bien qu'il ne soit pas utilisé actuellement dans ce BLoC.
// Si l'intention est d'avoir des ID uniques pour les todos, son utilisation devrait être intégrée.
import 'package:uuid/uuid.dart';
// Importe le modèle de données Todo, bien qu'il ne soit pas directement utilisé car le BLoC opère avec des Map<String, dynamic>.
// Il serait préférable d'utiliser directement TodoModel pour typer les todos.
import '../models/todo_model.dart';
import 'todo_events.dart'; // Importe les définitions des événements que ce BLoC peut gérer.
import 'todo_states.dart'; // Importe la définition de l'état que ce BLoC va émettre.

// Définition du BLoC pour la gestion de la liste des tâches (todos).
// Il écoute les TodoEvent et émet des TodoState.
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  // Constructeur du TodoBloc.
  // Initialise l'état avec une liste de todos vide.
  // Enregistre les gestionnaires pour chaque type d'événement.
  TodoBloc() : super(TodoState(todos: [])) {
    // Lorsqu'un événement AddTodo est reçu, la méthode _onAddTodo est appelée.
    on<AddTodo>(_onAddTodo);
    // Lorsqu'un événement RemoveTodo est reçu, la méthode _onRemoveTodo est appelée.
    on<RemoveTodo>(_onRemoveTodo);
    // Lorsqu'un événement TogleTodo est reçu (probablement une faute de frappe pour ToggleTodo),
    // la méthode _onToggleTodo est appelée.
    on<TogleTodo>(_onToggleTodo);
  }

  // Gestionnaire pour l'événement AddTodo.
  // Crée une nouvelle tâche (représentée comme un Map) avec les données de l'événement
  // et l'ajoute à la liste existante des tâches.
  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) {
    // Crée un nouveau Map représentant la tâche.
    // Il serait préférable d'utiliser un identifiant unique (par exemple, généré par Uuid).
    final newTodo = {
      'title': event.title,
      'subtitle': event.subtitle,
      'isCompleted': false, // Par défaut, une nouvelle tâche n'est pas complétée.
    };
    // Émet un nouvel état avec la nouvelle tâche ajoutée à la liste.
    // L'opérateur spread (...) est utilisé pour créer une nouvelle liste
    // contenant tous les éléments de l'ancienne liste plus le nouveau todo.
    emit(TodoState(todos: [...state.todos, newTodo]));
  }

  // Gestionnaire pour l'événement RemoveTodo.
  // Supprime une tâche de la liste en fonction de son index.
  void _onRemoveTodo(RemoveTodo event, Emitter<TodoState> emit) {
    // Crée une copie modifiable de la liste actuelle des tâches.
    final updatedTodos = List<Map<String, dynamic>>.from(state.todos)
    // Supprime l'élément à l'index spécifié par l'événement.
    // Attention : l'utilisation d'index peut être fragile si la liste est modifiée fréquemment
    // ou si les opérations sont asynchrones. Un ID unique serait plus robuste.
      ..removeAt(event.index);
    // Émet un nouvel état avec la liste des tâches mise à jour.
    emit(TodoState(todos: updatedTodos));
  }

  // Gestionnaire pour l'événement TogleTodo (probablement ToggleTodo).
  // Inverse l'état de complétion (isCompleted) d'une tâche spécifique.
  void _onToggleTodo(TogleTodo event, Emitter<TodoState> emit) {
    // Crée une copie modifiable de la liste actuelle des tâches.
    final updateTodos = List<Map<String, dynamic>>.from(state.todos);
    // Récupère la tâche à modifier en utilisant son index.
    final todo = updateTodos[event.index];

    // Met à jour la tâche à l'index spécifié.
    // **Attention : Il semble y avoir une erreur ici.**
    // **Le champ 'isCompleted' est copié tel quel, sans être inversé.**
    // **Il devrait être : 'isCompleted': !todo['isCompleted'],**
    updateTodos[event.index] = {
      'title': todo['title'],
      'subtitle': todo['subtitle'],
      'isCompleted': todo['isCompleted'], // ERREUR POTENTIELLE : Devrait être !todo['isCompleted']
    };

    // Émet un nouvel état avec la liste des tâches mise à jour.
    emit(TodoState(todos: updateTodos));
  }
}