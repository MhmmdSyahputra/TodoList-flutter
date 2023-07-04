import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sort/widget/cardCategory.dart';
import 'package:todo_sort/widget/cardProfile.dart';

import '../GlobalFunction.dart';
import '../provider/providerTheme.dart';
import '../provider/providersTodos.dart';
import '../utils/data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final provThemeMode = Provider.of<ThemeProvider>(context).enableDarkMode;

    final provCountTodo = Provider.of<TodoProvider>(context);

    listCheck() {
      return provCountTodo.todoList
          .where((allList) => allList.isCheck == true)
          .map((allList) {})
          .toList()
          .length;
    }

    listUnCheck() {
      return provCountTodo.todoList
          .where((allList) => allList.isCheck == false)
          .map((allList) {})
          .toList()
          .length;
    }

    allList() {
      return provCountTodo.todoList.map((allList) {}).toList().length;
    }

    displayText() {
      if (listUnCheck() == 0) {
        return 'All Task done';
      }
      return 'You still have ${listUnCheck()} task(s) to do';
    }

    return Container(
      color: myThemeBottom(provThemeMode),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            const CardProfile(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: listCategoryOptions.map((res) {
                  return CardCategory(data: res);
                }).toList(),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Card(
                  elevation: 4,
                  color: myThemeBottom(provThemeMode),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      SliderTheme(
                        data: const SliderThemeData(
                            thumbShape:
                                RoundSliderThumbShape(disabledThumbRadius: 0),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 0),
                            disabledInactiveTrackColor: Colors.grey,
                            disabledActiveTrackColor: Color(0xcc0077b6)),
                        child: Slider(
                            value: listCheck().toDouble(),
                            max:
                                allList().toDouble(), // Durasi lagu disesuaikan
                            onChanged: null),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${displayText()}',
                        style: TextStyle(color: myTheme(!provThemeMode)),
                      )
                    ]),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
