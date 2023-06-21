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
            )
          ],
        ),
      ),
    );
  }
}
