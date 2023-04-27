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
  List<Map<String, dynamic>> categoryOptions = [
    {'category': 'Routine', 'chipColor': Colors.orange},
    {'category': 'Work', 'chipColor': Colors.blue},
    {'category': 'Other', 'chipColor': Colors.green},
  ];
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
                            children: categoryOptions.map((option) {
                              return ChoiceChip(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                label: Text(
                                  option['category'],
                                  style: TextStyle(
                                    color:
                                        selectedCategory == option['category']
                                            ? Colors.white
                                            : Colors.black,
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
                                backgroundColor: Colors.transparent,
                                onSelected: (selected) {
                                  setState(() {
                                    selectedCategory =
                                        selected ? option['category'] : null;
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
                                final Map<String, dynamic> categoryOption =
                                    categoryOptions.firstWhere((option) =>
                                        option['category'] ==
                                        allList.kategetori);
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
                                            selectedCategory.toString(),
                                        color: categoryOption['chipColor']));
                              }).toList()
                            : TodoProvider.todoList
                                .where((allList) =>
                                    allList.kategetori == selectedCategory)
                                .map((allList) {
                                final Map<String, dynamic> categoryOption =
                                    categoryOptions.firstWhere((option) =>
                                        option['category'] ==
                                        allList.kategetori);
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
                                            selectedCategory.toString(),
                                        color: categoryOption['chipColor']));
                              }).toList()
                        : [Text("data masih kosong!")])
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
