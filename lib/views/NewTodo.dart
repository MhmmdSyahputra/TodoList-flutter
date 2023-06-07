import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sort/GlobalFunction.dart';
import 'package:todo_sort/model/modelTodo.dart';
import 'package:todo_sort/provider/providerTheme.dart';
import 'package:todo_sort/provider/providersTodos.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:todo_sort/utils/data.dart';
import 'package:todo_sort/views/MainTodo.dart';
import 'package:uuid/uuid.dart';

class NewTodosScreen extends StatefulWidget {
  const NewTodosScreen({super.key});

  @override
  State<NewTodosScreen> createState() => _NewTodosScreenState();
}

class _NewTodosScreenState extends State<NewTodosScreen> {
  final TextEditingController _titleInputController = TextEditingController();
  final TextEditingController _ketInputController = TextEditingController();
  String? dateStartInput;
  String? dateEndInput;
  String categoryValue = 'Routine';
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    final provThemeMode = Provider.of<ThemeProvider>(context).enableDarkMode;

    return Scaffold(
        backgroundColor: myTheme(provThemeMode),
        appBar: AppBar(
          backgroundColor: myThemeHead(provThemeMode),
          title: Text('Todos'),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Row(children: [
                    Expanded(
                        child: Row(
                      children: [
                        Icon(Icons.list_alt, color: myTheme(!provThemeMode)),
                        Text(
                          'Kegiatan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: myTheme(!provThemeMode)),
                        )
                      ],
                    )),
                    Expanded(
                        child: TextField(
                      controller: _titleInputController,
                      decoration: InputDecoration(
                          hintText: 'Judul Kegiatan',
                          hintStyle: TextStyle(color: myTheme(!provThemeMode)),
                          contentPadding: const EdgeInsets.all(15),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: myTheme(!provThemeMode), width: 1.0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ))
                  ]),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    Expanded(
                        child: Row(
                      children: [
                        Icon(
                          Icons.format_align_left_sharp,
                          color: myTheme(!provThemeMode),
                        ),
                        Text(
                          'Keterangan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: myTheme(!provThemeMode)),
                        )
                      ],
                    )),
                  ]),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    Expanded(
                        child: TextField(
                      controller: _ketInputController,
                      decoration: InputDecoration(
                          hintText: 'Tambah Keterangan',
                          hintStyle: TextStyle(color: myTheme(!provThemeMode)),
                          contentPadding: const EdgeInsets.only(
                              left: 20, top: 50, right: 20, bottom: 50),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: myTheme(!provThemeMode))),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ))
                  ]),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    Expanded(
                        child: Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: myTheme(!provThemeMode),
                        ),
                        Text(
                          'Tanggal Mulai',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: myTheme(!provThemeMode)),
                        )
                      ],
                    )),
                    Expanded(
                        child: Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: myTheme(!provThemeMode),
                        ),
                        Text(
                          'Tanggal Selesai',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: myTheme(!provThemeMode)),
                        )
                      ],
                    ))
                  ]),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    SizedBox(width: 20),
                    Expanded(
                        child: DateTimePicker(
                      initialValue: '',
                      dateHintText: '20-04-2023',
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onChanged: (val) => {dateStartInput = val},
                      validator: (val) {
                        dateStartInput = val;
                        return null;
                      },
                      onSaved: (val) => {dateStartInput = val},
                      style: TextStyle(
                        color: myTheme(
                            !provThemeMode), // Atur warna teks menjadi putih
                      ),
                    )),
                    SizedBox(width: 70),
                    Expanded(
                        child: DateTimePicker(
                      initialValue: '',
                      dateHintText: '20-04-2023',
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onChanged: (val) => {dateEndInput = val},
                      validator: (val) {
                        dateEndInput = val;
                        return null;
                      },
                      onSaved: (val) => {dateEndInput = val},
                      style: TextStyle(
                        color: myTheme(
                            !provThemeMode), // Atur warna teks menjadi putih
                      ),
                    )),
                    SizedBox(width: 20),
                  ]),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    Expanded(
                        child: Row(
                      children: [
                        Icon(
                          Icons.category,
                          color: myTheme(!provThemeMode),
                        ),
                        Text(
                          'Kategori',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: myTheme(!provThemeMode)),
                        )
                      ],
                    )),
                    Expanded(
                        child: DropdownButton<String>(
                      dropdownColor: myTheme(provThemeMode),
                      value: categoryValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      style: TextStyle(color: myTheme(!provThemeMode)),
                      underline: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          categoryValue = value!;
                        });
                      },
                      items: listCategoryOptions.map((value) {
                        return DropdownMenuItem<String>(
                          value: value['category'],
                          child: Text(value['category']),
                        );
                      }).toList(),
                    )),
                  ]),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    Expanded(
                        child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Batal'),
                    )),
                    SizedBox(width: 20),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Provider.of<TodoProvider>(context, listen: false)
                                  .AddTodo(TodoModel(
                                      id: uuid.v1(),
                                      title:
                                          _titleInputController.text.length == 0
                                              ? 'Untitle'
                                              : _titleInputController.text,
                                      keterangan:
                                          _ketInputController.text.length != 0
                                              ? _ketInputController.text
                                              : 'No Description',
                                      tglmulai: dateStartInput.toString(),
                                      tglselesai: dateEndInput.toString(),
                                      kategetori: categoryValue,
                                      isCheck: false));
                              Navigator.of(context).pop(MaterialPageRoute(
                                  builder: (context) => TodoListScreen()));

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: myTheme(provThemeMode),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: 180,
                                          width: 250,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                5, 50, 5, 5),
                                            child: Column(
                                              children: [
                                                Text('Berhasil',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: myTheme(
                                                            !provThemeMode)),
                                                    textAlign:
                                                        TextAlign.center),
                                                SizedBox(height: 10),
                                                Text(
                                                    'Kegiatan berhasil ditambahkan',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: myTheme(
                                                            !provThemeMode)),
                                                    textAlign:
                                                        TextAlign.center),
                                                SizedBox(height: 20),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('OK'),
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.green,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15,
                                                          horizontal: 35)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top: -30,
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.white,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.green,
                                                radius: 26,
                                                child: Icon(Icons.check,
                                                    size: 30,
                                                    color: Colors.white),
                                              ),
                                            )),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text('Simpan'),
                            style: ElevatedButton.styleFrom(
                              primary: myThemeHead(provThemeMode),
                            ))),
                  ]),
                ),
              ],
            ),
          ],
        ));
  }
}
