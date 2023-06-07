import 'package:flutter/material.dart';
import 'package:todo_sort/provider/providerTheme.dart';
import 'package:todo_sort/provider/providersTodos.dart';
import 'package:provider/provider.dart';
import 'package:todo_sort/views/MainMenuBottom.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final prov = Provider.of<ThemeProvider>(context);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => TodoProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: Color(0xFF4E37A9),
            ),
            home: const BottomNavMain()));
  }
}
