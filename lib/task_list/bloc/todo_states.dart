import '../models/todo_model.dart';

// L'etat est simplemement la liste des taches
class TodoState {
  final List<Map<String, dynamic>> todos;
  TodoState({required this.todos});
}
