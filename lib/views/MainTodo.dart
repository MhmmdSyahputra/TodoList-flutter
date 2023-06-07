import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sort/provider/providerTheme.dart';
import 'package:todo_sort/utils/data.dart';
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

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ThemeProvider>(context);
    final provThemeMode = Provider.of<ThemeProvider>(context).enableDarkMode;

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
              color: myTheme(prov.enableDarkMode),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: listCategoryOptions.map((option) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: ChoiceChip(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                label: Text(
                                  option['category'],
                                  style: TextStyle(
                                    color:
                                        selectedCategory == option['category']
                                            ? prov.enableDarkMode
                                                ? Color(0xccffffff)
                                                : Color(0xcc14213d)
                                            : option['chipColor'],
                                  ),
                                ),
                                selected:
                                    selectedCategory == option['category'],
                                selectedColor: option['chipColor'],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                    color: option['chipColor'],
                                    width: 2,
                                  ),
                                ),
                                backgroundColor: myTheme(prov.enableDarkMode),
                                onSelected: (selected) {
                                  setState(() {
                                    selectedCategory =
                                        selected ? option['category'] : null;
                                  });
                                },
                              ),
                            );
                          }).toList()),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Unfinished',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: myTheme(!provThemeMode)),
                      ),
                      Divider(color: myTheme(!provThemeMode)),
                      Column(
                          children: selectedCategory == null
                              ? TodoProvider.todoList
                                  .where((allList) => allList.isCheck == false)
                                  .map((allList) {
                                  final Map<String, dynamic> categoryOption =
                                      listCategoryOptions.firstWhere((option) =>
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
                                      allList.kategetori == selectedCategory &&
                                      allList.isCheck == false)
                                  .map((allList) {
                                  final Map<String, dynamic> categoryOption =
                                      listCategoryOptions.firstWhere((option) =>
                                          option['category'] ==
                                          allList.kategetori);
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: CardTodo(
                                        data: allList,
                                        color: categoryOption['chipColor'],
                                      ));
                                }).toList()),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Finished',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: myTheme(!provThemeMode)),
                      ),
                      Divider(color: myTheme(!provThemeMode)),
                      Column(
                          children: selectedCategory == null
                              ? TodoProvider.todoList
                                  .where((allList) => allList.isCheck == true)
                                  .map((allList) {
                                  final Map<String, dynamic> categoryOption =
                                      listCategoryOptions.firstWhere((option) =>
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
                                      allList.kategetori == selectedCategory &&
                                      allList.isCheck == true)
                                  .map((allList) {
                                  final Map<String, dynamic> categoryOption =
                                      listCategoryOptions.firstWhere((option) =>
                                          option['category'] ==
                                          allList.kategetori);
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: CardTodo(
                                        data: allList,
                                        color: categoryOption['chipColor'],
                                      ));
                                }).toList())
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
