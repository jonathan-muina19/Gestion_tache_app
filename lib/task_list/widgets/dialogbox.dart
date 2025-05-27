import 'package:app_test/task_list/bloc/todo_events.dart';
import 'package:app_test/task_list/widgets/my_button.dart';
import 'package:app_test/task_list/widgets/my_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';

class Dialogbox extends StatefulWidget {
  @override
  State<Dialogbox> createState() => _DialogboxState();
}

class _DialogboxState extends State<Dialogbox> {
  final TextEditingController _controllerTaskTitle = TextEditingController();
  final TextEditingController _controllerTaskSubTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.business_center_sharp, color: Colors.deepPurpleAccent),
      title: Text(
        'Gestion des taches',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.grey[300],
      content: SingleChildScrollView(
        child: Container(
          //height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Zone des textes pour le titre de la tache
              // Et le sous titre
              MyTextfield(
                controller: _controllerTaskTitle,
                labelText: 'Ajouter une tache',
              ),
              SizedBox(height: 10),
              MyTextfield(
                controller: _controllerTaskSubTitle,
                labelText: 'Sous titre',
                contentPanding: EdgeInsets.symmetric(
                  vertical: 35,
                  horizontal: 10,
                ),
              ),
              SizedBox(height: 20),
              // Les bouttons pour ajouter
              // Et annuler
              SizedBox(height: 20),
              MyButton(
                onTap: () {
                  final title = _controllerTaskTitle.text.trim();
                  final subtitle = _controllerTaskSubTitle.text.trim();

                  if (title.isNotEmpty && subtitle.isNotEmpty) {
                    context.read<TodoBloc>().add(
                      AddTodo(title: title, subtitle: subtitle),
                    );
                    _controllerTaskTitle.clear();
                    _controllerTaskSubTitle.clear();
                  }
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
