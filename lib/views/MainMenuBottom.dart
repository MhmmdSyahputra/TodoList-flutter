import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sort/provider/providersTodos.dart';
import 'package:todo_sort/utils/data.dart';
import 'package:todo_sort/views/MainTodo.dart';
import '../GlobalFunction.dart';
import '../provider/providerTheme.dart';

class BottomNavMain extends StatefulWidget {
  const BottomNavMain({super.key});

  @override
  State<BottomNavMain> createState() => _BottomNavMainState();
}

class _BottomNavMainState extends State<BottomNavMain> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Todos'),
    Text('Calender'),
    Text('Profil'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provThemeMode = Provider.of<ThemeProvider>(context).enableDarkMode;
    final prov = Provider.of<ThemeProvider>(context);

    final provCountTodo = Provider.of<TodoProvider>(context);

    countCheckList(category) {
      return provCountTodo.todoList
          .where((allList) =>
              allList.kategetori == category && allList.isCheck == false)
          .map((allList) {})
          .toList()
          .length;
    }

    Widget body = _widgetOptions.elementAt(_selectedIndex);
    switch (_selectedIndex) {
      case 0:
        body = TodoListScreen();
        break;
      case 1:
        // body = ;
        break;
      case 2:
        // body = ;
        break;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todos'),
          centerTitle: true,
          backgroundColor: myThemeHead(provThemeMode),
          actions: [
            provThemeMode ? Icon(Icons.dark_mode) : Icon(Icons.light_mode),
          ],
        ),
        body: body,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: myThemeBottom(provThemeMode),
          elevation: 10,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list_alt_outlined,
                color: myTheme(!provThemeMode),
              ),
              label: 'Todos',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month,
                color: myTheme(!provThemeMode),
              ),
              label: 'Calender',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: myTheme(!provThemeMode),
              ),
              label: 'Person',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor:
              Colors.black, // ubah warna ikon yang dipilih menjadi hitam
          unselectedItemColor: Colors.black.withOpacity(
              0.6), // ubah warna ikon yang tidak dipilih menjadi hitam transparan
        ),
        drawer: Drawer(
          backgroundColor: myTheme(provThemeMode),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Todo App",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: myTheme(!provThemeMode)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "By Muhammad Syahputra",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: myTheme(!provThemeMode)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: listCategoryOptions.map((value) {
                  return ListTile(
                    title: Text(
                      value['category'],
                      style: TextStyle(color: myTheme(!provThemeMode)),
                    ),
                    trailing: Visibility(
                      visible: countCheckList(value['category']) != 0,
                      child: CircleAvatar(
                        backgroundColor: value['chipColor'],
                        child:
                            Text(countCheckList(value['category']).toString()),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 30,
              ),
              ListTile(
                title: Text('Dark Mode',
                    style: TextStyle(color: myTheme(!provThemeMode))),
                trailing: Switch(
                  value: provThemeMode,
                  activeColor: Colors.cyan,
                  onChanged: (bool value) {
                    setState(() {
                      prov.SetBrightness(value);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
