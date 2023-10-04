import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/model/task_data.dart';
import 'package:todoey_flutter/widgets/task_title.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, child) {
      return ListView.builder(
        itemCount: taskData.taskCount,
        itemBuilder: (context, index) => TaskTitle(
          task: taskData.listaTask[index].name,
          isChecked: taskData.listaTask[index].isDone,
          checkboxCallback: (checkstate) {
            taskData.updateTask(taskData.listaTask[index]);
          },
          removeItemCallback: () {
            taskData.removeTask(index);
          },
        ),
      );
    });
  }
}

/*
children: [
TaskTitle(task: tasks[0].name , isChecked:  tasks[0].isDone),
TaskTitle(task: tasks[1].name , isChecked:  tasks[1].isDone),
TaskTitle(task: tasks[2].name , isChecked:  tasks[2].isDone),
],*/
