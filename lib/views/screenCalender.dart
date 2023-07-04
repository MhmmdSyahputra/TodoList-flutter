import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_sort/model/modelTodoCal.dart';
import 'package:todo_sort/provider/providersTodosCal.dart';

import '../GlobalFunction.dart';
import '../provider/providerTheme.dart';
import 'package:intl/intl.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class EventTime {
  String title = "";
  String subtitle = "";
  String startDate = "";
  String endDate = "";
  EventTime(this.title, this.subtitle, this.startDate, this.endDate);
}

class _CalenderScreenState extends State<CalenderScreen> {
  late CalendarFormat _calendarFormat;
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late Map<DateTime, List> _events;

  List<EventTime> eventData = [];
  TextEditingController judulController = TextEditingController();
  TextEditingController additionalController = TextEditingController();
  TextEditingController tglMulaiController = TextEditingController();
  TextEditingController tglSelesaiController = TextEditingController();

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
    final provTodoCal = Provider.of<TodoCalProvider>(context);

    return Scaffold(
      backgroundColor: myThemeBottom(provThemeMode),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
            ListTile(
              leading: Text('Event',
                  style: TextStyle(color: myTheme(!provThemeMode))),
              trailing: InkWell(
                  onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: TextField(
                                      controller: judulController,
                                      style: TextStyle(
                                        color: Colors
                                            .black, //Sesuaikan warna dengan kebutuhan
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Nama Event',
                                        labelStyle: TextStyle(
                                          color: Colors
                                              .black, //Sesuaikan warna dengan kebutuhan
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors
                                                .black, //Sesuaikan warna dengan kebutuhan
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors
                                                .black, //Sesuaikan warna dengan kebutuhan
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: TextField(
                                      controller: additionalController,
                                      style: TextStyle(
                                        color: Colors
                                            .black, //Sesuaikan warna dengan kebutuhan
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Keterangan tambahan',
                                        labelStyle: TextStyle(
                                          color: Colors
                                              .black, //Sesuaikan warna dengan kebutuhan
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors
                                                .black, //Sesuaikan warna dengan kebutuhan
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors
                                                .black, //Sesuaikan warna dengan kebutuhan
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: TextField(
                                      controller: tglMulaiController,
                                      style: TextStyle(
                                        color: Colors
                                            .black, //Sesuaikan warna dengan kebutuhan
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Tanggal mulai',
                                        labelStyle: TextStyle(
                                          color: Colors
                                              .black, //Sesuaikan warna dengan kebutuhan
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors
                                                .black, //Sesuaikan warna dengan kebutuhan
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors
                                                .black, //Sesuaikan warna dengan kebutuhan
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        var selectedDate = DateTime.now();
                                        final DateTime? picked =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: selectedDate,
                                          initialDatePickerMode:
                                              DatePickerMode.day,
                                          firstDate: DateTime(2015),
                                          lastDate: DateTime(2101),
                                          initialEntryMode:
                                              DatePickerEntryMode.calendarOnly,
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                dialogBackgroundColor: Colors
                                                    .white, //Sesuaikan warna dengan kebutuhan
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (picked != null) {
                                          setState(() {
                                            selectedDate = picked;
                                            tglMulaiController.text =
                                                DateFormat('dd MMM yyyy')
                                                    .format(selectedDate);
                                          });
                                        }
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: TextField(
                                      controller: tglSelesaiController,
                                      style: TextStyle(
                                        color: Colors
                                            .black, //Sesuaikan warna dengan kebutuhan
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Tanggal selesai',
                                        labelStyle: TextStyle(
                                          color: Colors
                                              .black, //Sesuaikan warna dengan kebutuhan
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors
                                                .black, //Sesuaikan warna dengan kebutuhan
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors
                                                .black, //Sesuaikan warna dengan kebutuhan
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        var selectedDate = DateTime.now();
                                        final DateTime? picked =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: selectedDate,
                                          initialDatePickerMode:
                                              DatePickerMode.day,
                                          firstDate: DateTime(2015),
                                          lastDate: DateTime(2101),
                                          initialEntryMode:
                                              DatePickerEntryMode.calendarOnly,
                                          builder: (context, child) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                dialogBackgroundColor: Colors
                                                    .white, //Sesuaikan warna dengan kebutuhan
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (picked != null) {
                                          setState(() {
                                            selectedDate = picked;
                                            tglSelesaiController.text =
                                                DateFormat('dd MMM yyyy')
                                                    .format(selectedDate);
                                          });
                                        }
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("CANCEL",
                                    style: TextStyle(color: Colors.grey)),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    Provider.of<TodoCalProvider>(context,
                                            listen: false)
                                        .AddTodoCal(TodoCalModel(
                                      title: judulController.text.isNotEmpty
                                          ? judulController.text
                                          : 'Untitle',
                                      keterangan:
                                          additionalController.text.isNotEmpty
                                              ? additionalController.text
                                              : '-',
                                      tglmulai: tglMulaiController.text,
                                      tglselesai: tglSelesaiController.text,
                                    ));
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: Text("SET"),
                              ),
                            ],
                          );
                        },
                      ),
                  child: Icon(Icons.add, color: myTheme(!provThemeMode))),
            ),
            Divider(
              color: myTheme(!provThemeMode),
            ),
            Container(
              child: Column(
                  children: provTodoCal.todoCalList.map((res) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    color: myThemeBottom(provThemeMode),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          trailing: InkWell(
                            onTap: () => provTodoCal.RemoveTodoCal(res),
                            child: Icon(
                              Icons.remove_circle_outline,
                              color: Colors.red,
                            ),
                          ),
                          leading: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${res.title}',
                                style: TextStyle(
                                    color: myTheme(!provThemeMode),
                                    fontSize: 18),
                              ),
                              Text(
                                '${res.keterangan}',
                                style:
                                    TextStyle(color: myTheme(!provThemeMode)),
                              ),
                              Text(
                                res.tglmulai == res.tglselesai
                                    ? res.tglmulai
                                    : '${res.tglmulai} - ${res.tglselesai}',
                                style:
                                    TextStyle(color: myTheme(!provThemeMode)),
                              ),
                            ],
                          )),
                    ),
                  ),
                );
              }).toList()),
            )
          ],
        ),
      ),
    );
  }
}
