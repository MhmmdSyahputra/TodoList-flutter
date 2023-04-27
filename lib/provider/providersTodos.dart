import 'package:flutter/material.dart';
import 'package:todo_sort/model/modelTodo.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModel> _todoList = [];

  List<TodoModel> get todoList => _todoList;

  void AddTodo(TodoModel todo) {
    _todoList.add(todo);
    notifyListeners();
  }

  void updateTodoStatus(String id, bool isChecked) {
    final int todoIndex = _todoList.indexWhere((todo) => todo.id == id);
    if (todoIndex != -1) {
      _todoList[todoIndex].isCheck = isChecked;
      notifyListeners();
    }
  }
}
