import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../GlobalFunction.dart';
import '../provider/providerTheme.dart';
import '../provider/providersTodos.dart';

class CardProfile extends StatelessWidget {
  const CardProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final provCountTodo = Provider.of<TodoProvider>(context);

    final totAll = provCountTodo.todoList
        .where((allList) => allList.isCheck == true)
        .map((allList) {})
        .toList()
        .length;

    final provThemeMode = Provider.of<ThemeProvider>(context).enableDarkMode;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: 4,
        color: myThemeBottom(provThemeMode),
        child: ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(
            'Muhammad Syahputra',
            style: TextStyle(color: myTheme(!provThemeMode)),
          ),
          subtitle: Text('Task finished : ${totAll}',
              style: TextStyle(color: myTheme(!provThemeMode))),
        ),
      ),
    );
  }
}
