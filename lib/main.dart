import 'package:app_test/task_list/bloc/todo_bloc.dart';
import 'package:app_test/task_list/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(create: (_) => TodoBloc(), child: HomePage()),
    );
  }
}
