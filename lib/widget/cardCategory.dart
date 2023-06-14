import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../GlobalFunction.dart';
import '../provider/providerTheme.dart';
import '../provider/providersTodos.dart';

class CardCategory extends StatelessWidget {
  final data;
  const CardCategory({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final provCountTodo = Provider.of<TodoProvider>(context);

    final totAll = provCountTodo.todoList
        .where((allList) => allList.isCheck == true)
        .map((allList) {})
        .toList()
        .length;

    int getListCheck(category) {
      return provCountTodo.todoList
          .where((allList) =>
              allList.kategetori == category && allList.isCheck == true)
          .map((allList) {})
          .toList()
          .length;
    }

    final provThemeMode = Provider.of<ThemeProvider>(context).enableDarkMode;
    return SizedBox(
      height: 120,
      width: MediaQuery.of(context).size.width / 3.5,
      child: Card(
        color: myThemeBottom(provThemeMode),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data['category'],
                style: TextStyle(color: myTheme(!provThemeMode))),
            Text(
              '${getListCheck(data['category'])}',
              style: TextStyle(
                fontSize: 50,
                color: data['chipColor'],
              ),
            ),
            Text('Finished', style: TextStyle(color: myTheme(!provThemeMode))),
          ],
        ),
      ),
    );
    ;
  }
}
