import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../GlobalFunction.dart';
import '../provider/providerTheme.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  late CalendarFormat _calendarFormat;
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late Map<DateTime, List> _events;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _events = {}; // Anda dapat mengisi _events dengan daftar acara
  }

  @override
  Widget build(BuildContext context) {
    final provThemeMode = Provider.of<ThemeProvider>(context).enableDarkMode;

    return Scaffold(
      body: Container(
        color: myThemeBottom(provThemeMode),
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarStyle: CalendarStyle(
            weekendTextStyle: TextStyle(color: myTheme(!provThemeMode)),
            defaultTextStyle: TextStyle(
              color: myTheme(!provThemeMode),
            ),
            todayDecoration: BoxDecoration(
              color: myThemeHead(!provThemeMode),
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: myThemeHead(!provThemeMode),
              shape: BoxShape.circle,
            ),
            // markersAnchor: Theme.of(context).colorScheme.error,
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: TextStyle(color: myTheme(!provThemeMode)),
            weekdayStyle: TextStyle(color: myTheme(!provThemeMode)),
          ),
          headerStyle: HeaderStyle(
            titleTextStyle: TextStyle(
              color: myTheme(!provThemeMode),
            ),
            formatButtonTextStyle: TextStyle(
              color: Colors.white,
            ),
            formatButtonDecoration: BoxDecoration(
              color: myThemeHead(!provThemeMode),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }
}
