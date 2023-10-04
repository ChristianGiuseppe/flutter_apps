import 'package:flutter/material.dart';
import 'package:todoey_flutter/model/task_data.dart';
import 'package:todoey_flutter/screens/tasks_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const TodoEy());
}

class TodoEy extends StatelessWidget {
  const TodoEy({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: const MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
