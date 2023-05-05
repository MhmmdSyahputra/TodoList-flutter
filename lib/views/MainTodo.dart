import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sort/provider/providerTheme.dart';

import '../GlobalFunction.dart';
import '../provider/providersTodos.dart';
import '../widget/cardTodo.dart';
import 'newTodo.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  String? selectedCategory;
  bool isCheckedTodo = false;
  List<Map<String, dynamic>> categoryOptions = [
    {'category': 'Routine', 'chipColor': Colors.orange},
    {'category': 'Work', 'chipColor': Colors.blue},
    {'category': 'Other', 'chipColor': Colors.green},
  ];
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Consumer<TodoProvider>(builder: (
        context,
        TodoProvider,
        child,
      ) {
        return ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: MyTheme(prov.enableDarkMode),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 50,
                          // color: Colors.orange,
                          child: GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 1,
                              children: [
                                Wrap(
                                  spacing: 10.0,
                                  children: categoryOptions.map((option) {
                                    return ChoiceChip(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      label: Text(
                                        option['category'],
                                        style: TextStyle(
                                          color: selectedCategory ==
                                                  option['category']
                                              ? prov.enableDarkMode
                                                  ? Color(0xccffffff)
                                                  : Color(0xcc14213d)
                                              : option['chipColor'],
                                        ),
                                      ),
                                      selected: selectedCategory ==
                                          option['category'],
                                      selectedColor: option['chipColor'],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide(
                                          color: option['chipColor'],
                                          width: 2,
                                        ),
                                      ),
                                      backgroundColor:
                                          MyTheme(prov.enableDarkMode),
                                      onSelected: (selected) {
                                        setState(() {
                                          selectedCategory = selected
                                              ? option['category']
                                              : null;
                                        });
                                      },
                                    );
                                  }).toList(),
                                )
                              ])),
                      Column(
                          children: TodoProvider.todoList.isNotEmpty
                              ? selectedCategory == null
                                  ? TodoProvider.todoList.map((allList) {
                                      final Map<String, dynamic>
                                          categoryOption =
                                          categoryOptions.firstWhere((option) =>
                                              option['category'] ==
                                              allList.kategetori);
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: CardTodo(
                                            data: allList,
                                            color: categoryOption['chipColor'],
                                          ));
                                    }).toList()
                                  : TodoProvider.todoList
                                      .where((allList) =>
                                          allList.kategetori ==
                                          selectedCategory)
                                      .map((allList) {
                                      final Map<String, dynamic>
                                          categoryOption =
                                          categoryOptions.firstWhere((option) =>
                                              option['category'] ==
                                              allList.kategetori);
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: CardTodo(
                                            data: allList,
                                            color: categoryOption['chipColor'],
                                          ));
                                    }).toList()
                              : [Text("data masih kosong!")])
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return NewTodosScreen();
              },
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
