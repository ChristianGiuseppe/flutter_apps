import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/model/task.dart';
import 'package:todoey_flutter/model/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  String newTaskTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            'ADD TASK',
            style: TextStyle(
                color: Colors.lightGreenAccent,
                fontSize: 30.0,
                fontWeight: FontWeight.w700),
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (newText){
              newTaskTitle = newText;
            },
          ),
          Container(
              width: double.infinity,
              child: FlatButton(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                  onPressed: () {
                    Task newTask  = new Task(name: newTaskTitle);
                    Provider.of<TaskData>(context).addTask(newTask);
                    Navigator.pop(context);
                  },
                  color: Colors.lightGreenAccent,
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  )))
        ]),
      ),
    );
  }
}
