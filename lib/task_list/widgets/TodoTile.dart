import 'package:app_test/task_list/bloc/todo_bloc.dart';
import 'package:app_test/task_list/bloc/todo_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Todotile extends StatelessWidget {
  final String title;
  final String subtitle;
  final int index;
  // Function()? add;

  Todotile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.index
  });

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Supprimer cette tâche ?'),
        content: const Text('Cette action est irréversible.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext), // Annuler
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              context.read<TodoBloc>().add(RemoveTodo(index));
              Navigator.pop(dialogContext); // Fermer la boîte de dialogue
            },
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //leading: Icon(Icons.person),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              _showDeleteConfirmation(context);
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      isThreeLine: false,
      tileColor: Colors.white,
      dense: false,
      enabled: true,
      selected: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      //selectedColor: Colors.grey,
      selectedTileColor: Colors.deepPurple.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }


}


