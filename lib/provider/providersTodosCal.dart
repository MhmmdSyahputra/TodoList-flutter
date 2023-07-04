import 'package:flutter/material.dart';
import 'package:todo_sort/model/modelTodo.dart';
import 'package:todo_sort/model/modelTodoCal.dart';

class TodoCalProvider with ChangeNotifier {
  List<TodoCalModel> _todoCalList = [];

  List<TodoCalModel> get todoCalList => _todoCalList;

  void AddTodoCal(TodoCalModel todo) {
    _todoCalList.add(todo);
    notifyListeners();
  }

  void RemoveTodoCal(TodoCalModel todo) {
    _todoCalList.remove(todo);
    notifyListeners();
  }

  // void updateTodoStatus(String id, bool isChecked) {
  //   final int todoIndex = _todoCalList.indexWhere((todo) => todo.id == id);
  //   if (todoIndex != -1) {
  //     _todoCalList[todoIndex].isCheck = isChecked;
  //     notifyListeners();
  //   }
  // }
}
