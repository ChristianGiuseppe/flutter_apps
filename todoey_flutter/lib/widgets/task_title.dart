import 'package:flutter/material.dart';

class TaskTitle extends StatelessWidget {
  const TaskTitle(
      {super.key,
      required this.task,
      this.isChecked = false,
      required this.checkboxCallback,
      required this.removeItemCallback});

  final String task;
  final bool isChecked;
  final Function(bool?)? checkboxCallback;
  final Function()? removeItemCallback;
  /*void checkboxCallback(newValue){
    setState(() {
      isChecked = newValue;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: removeItemCallback,
      title: Text(
        task,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.green,
        onChanged: (value) {
          checkboxCallback!(value);
        },
        value: isChecked,
      ),
    );
  }
}
