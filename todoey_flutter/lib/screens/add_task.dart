// ignore_for_file: duplicate_ignore

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/model/task.dart';
import 'package:todoey_flutter/model/task_data.dart';

@immutable
class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);
  String? newTaskTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Text(
            'ADD TASK',
            style: TextStyle(
                color: Colors.lightGreenAccent,
                fontSize: 30.0,
                fontWeight: FontWeight.w700),
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newTaskTitle = newText;
            },
          ),
          SizedBox(
              width: double.infinity,
              child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12.0),
                    backgroundColor: Colors.lightGreenAccent,
                  ),
                  onPressed: () {
                    if (newTaskTitle == null || newTaskTitle!.isEmpty) {
                      return;
                    }
                    Task newTask = Task(name: newTaskTitle!);
                    Provider.of<TaskData>(context, listen: false)
                        .addTask(newTask);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  )))
        ]),
      ),
    );
  }
}
