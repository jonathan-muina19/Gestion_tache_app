import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_model.dart';
import 'todo_events.dart';
import 'todo_states.dart';

// On cree notre bloc
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  // Constructeur bloc
  // Chaque on<...> ecoute un type d'evenement, quand il est delencher
  // il appelle la fonction correspondate
  TodoBloc() : super(TodoState(todos: [])) {
    on<AddTodo>(_onAddTodo);
    on<RemoveTodo>(_onRemoveTodo);
    on<TogleTodo>(_onToggleTodo);
  }

  // On cree un nouveau Todo avec les donnes recus dans l'evenement
  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) {
    final newTodo = {
      'title': event.title,
      'subtitle': event.subtitle,
      'isCompleted': false,
    };
    emit(TodoState(todos: [...state.todos, newTodo]));
  }

  // on filtre la liste actuelle et on retire la tache avec L'ID
  void _onRemoveTodo(RemoveTodo event, Emitter<TodoState> emit) {
    final updatedTodos = List<Map<String, dynamic>>.from(state.todos)
      ..removeAt(event.index);
    emit(TodoState(todos: updatedTodos));
  }

  // On parcourt la liste des taches, on cree une copie inverse
  // du champ isCompleted, sinon on garde la tache telle quelle
  void _onToggleTodo(TogleTodo event, Emitter<TodoState> emit) {
    final updateTodos = List<Map<String, dynamic>>.from(state.todos);
    final todo = updateTodos[event.index];

    updateTodos[event.index] = {
      'title': todo['title'],
      'subtitle': todo['subtitle'],
      'isCompleted': todo['isCompleted'],
    };

    emit(TodoState(todos: updateTodos));
  }
}
