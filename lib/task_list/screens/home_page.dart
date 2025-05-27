import 'package:app_test/task_list/bloc/todo_events.dart';
import 'package:app_test/task_list/bloc/todo_states.dart';
import 'package:app_test/task_list/widgets/TodoTile.dart';
import 'package:app_test/task_list/widgets/dialogbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controllerTitleTask = TextEditingController();
  final TextEditingController _controllerSubTitleTask = TextEditingController();

  void showDialogTask() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<TodoBloc>(), // réutilise le bloc existant
          child: Dialogbox(), // maintenant le bloc est accessible
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Todo Bloc',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          showDialogTask();
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  final todos = state.todos;
                  if (todos.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/liste.png", width: 200, height: 150,),
                        Center(
                            child: Text('Aucune tache disponible',style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                            ),
                          )
                        )
                      ],
                    );
                  }
                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return Column(
                        children: [
                          Todotile(
                            title: todo['title'],
                            subtitle: todo['subtitle'],
                            index: index,
                          ),
                          SizedBox(height: 10)
                        ],
                      );
                    },
                  );
                },
              )
            ),


          ],
        ),

      ),
    );
  }
}
