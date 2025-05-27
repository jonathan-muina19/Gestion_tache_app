abstract class TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  final String subtitle;

  AddTodo({required this.title, required this.subtitle});
}

class RemoveTodo extends TodoEvent {
  final int index;

  RemoveTodo(this.index);
}

class TogleTodo extends TodoEvent {
  final int index;

  TogleTodo(this.index);
}
