import 'package:flutter/material.dart';
import 'package:todo_sort/provider/providersTodos.dart';
import 'package:provider/provider.dart';
import 'package:todo_sort/views/MainTodo.dart';
import 'package:todo_sort/views/newTodo.dart';
import 'package:todo_sort/widget/cardTodo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => TodoProvider(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: Color(0xFF4E37A9),
            ),
            home: const TodoListScreen()));
  }
}
