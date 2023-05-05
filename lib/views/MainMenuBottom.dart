import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          backgroundColor: MyThemeHead(provThemeMode),
          actions: [
            provThemeMode ? Icon(Icons.dark_mode) : Icon(Icons.light_mode),
            Switch(
              value: provThemeMode,
              activeColor: Colors.cyan,
              onChanged: (bool value) {
                setState(() {
                  prov.SetBrightness(value);
                });
              },
            )
          ],
        ),
        body: body,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: MyThemeBottom(provThemeMode),
          elevation: 10,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list_alt_outlined,
                color: MyTheme(!provThemeMode),
              ),
              label: 'Todos',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month,
                color: MyTheme(!provThemeMode),
              ),
              label: 'Calender',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: MyTheme(!provThemeMode),
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
      ),
    );
  }
}

enum MenuItem {
  Profil,
  Pengaturan,
  Logout,
}
