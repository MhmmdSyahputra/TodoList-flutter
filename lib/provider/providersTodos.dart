import 'package:flutter/material.dart';
import 'package:todo_sort/model/modelTodo.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModel> _todoList = [];

  List<TodoModel> get todoList => _todoList;

  void AddTodo(TodoModel todo) {
    _todoList.add(todo);
    notifyListeners();
  }
}
