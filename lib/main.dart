import 'package:flutter/material.dart';
import 'package:todo_sort/newTodo.dart';
import 'package:todo_sort/provider/providersTodos.dart';
import 'package:provider/provider.dart';
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
            home: const MyHomePage(title: 'Todos')));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedCategory;
  bool isCheckedTodo = false;
  List<String> categoryOptions = ['Routine', 'Work', 'Others'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Consumer<TodoProvider>(builder: (
        context,
        TodoProvider,
        child,
      ) {
        return Padding(
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
                            children:
                                categoryOptions.asMap().entries.map((entry) {
                              final int index = entry.key;
                              final String category = entry.value;
                              Color chipColor = Colors.green;

                              if (index == 0) {
                                chipColor = Colors.orange;
                              } else if (index == 1) {
                                chipColor = Colors.blue;
                              }

                              return ChoiceChip(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                label: Text(
                                  category,
                                  style: TextStyle(
                                    color: selectedCategory == category
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                selected: selectedCategory == category,
                                selectedColor: chipColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                    color: chipColor,
                                    width: 2,
                                  ),
                                ),
                                backgroundColor: Colors.transparent,
                                onSelected: (selected) {
                                  setState(() {
                                    selectedCategory =
                                        selected ? category : null;
                                  });
                                },
                              );
                            }).toList(),
                          )
                        ])),
                Column(
                    children: TodoProvider.todoList.isNotEmpty
                        ? TodoProvider.todoList.map((allList) {
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: CardTodo(
                                    title: allList.title,
                                    keterangan: allList.keterangan,
                                    dateStart: allList.tglmulai,
                                    dateEnd: allList.tglselesai,
                                    category: allList.kategetori,
                                    selectedCategory:
                                        selectedCategory.toString()));
                          }).toList()
                        : [Text("data masih kosong!")]
                    // ],
                    )
              ],
            ),
          ),
        );
      }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return NewTodos();
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
