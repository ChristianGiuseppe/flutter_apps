import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/model/task_data.dart';

class TaskTitle extends StatelessWidget {
  TaskTitle({this.task, this.isChecked, this.checkboxCallback, this.removeItemCallback});

  final String task;
  bool isChecked = false;
  final Function checkboxCallback;
  final Function removeItemCallback;
 /*void checkboxCallback(newValue){
    setState(() {
      isChecked = newValue;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: removeItemCallback,
      title: Text(task,
      style: TextStyle(decoration:  isChecked ? TextDecoration.lineThrough: null),),
      trailing:Checkbox(
        activeColor: Colors.green,
        onChanged: checkboxCallback,
        value: isChecked,
      ),
    );
  }
}