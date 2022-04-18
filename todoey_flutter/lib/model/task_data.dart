import 'package:flutter/foundation.dart';
import 'package:todoey_flutter/model/task.dart';

class TaskData extends ChangeNotifier{
  List<Task> listaTask= [];

  int get taskCount {
    return listaTask.length;
  }

  void addTask(Task newTask){
    listaTask.add(newTask);
    notifyListeners();
  }

  void updateTask(Task  task){
    task.toggleDone();
    notifyListeners();
  }

  void removeTask(int index){
    listaTask.removeAt(index);
    notifyListeners();
  }
}