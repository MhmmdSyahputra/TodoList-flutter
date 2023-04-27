import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sort/main.dart';
import 'package:todo_sort/model/modelTodo.dart';
import 'package:todo_sort/provider/providersTodos.dart';
import 'package:date_time_picker/date_time_picker.dart';
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
    final List<String> listCategory = <String>['Routine', 'Work', 'Other'];
    return Scaffold(
        appBar: AppBar(
          title: Text("Todos"),
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
                        Icon(Icons.list_alt),
                        Text(
                          "Kegiatan",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                    Expanded(
                        child: TextField(
                      controller: _titleInputController,
                      decoration: InputDecoration(
                          hintText: 'Judul Kegiatan',
                          contentPadding: const EdgeInsets.all(15),
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
                        Icon(Icons.format_align_left_sharp),
                        Text(
                          "Keterangan",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                          contentPadding: const EdgeInsets.only(
                              left: 20, top: 50, right: 20, bottom: 50),
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
                        Icon(Icons.date_range),
                        Text(
                          "Tanggal Mulai",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                    Expanded(
                        child: Row(
                      children: [
                        Icon(Icons.date_range),
                        Text(
                          "Tanggal Selesai",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                        Icon(Icons.category),
                        Text(
                          "Kategori",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                    Expanded(
                        child: Row(
                      children: [
                        DropdownButton<String>(
                          value: categoryValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              categoryValue = value!;
                            });
                          },
                          items: listCategory
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
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
                        child: OutlinedButton(
                      onPressed: () {},
                      child: Text("Batal"),
                    )),
                    SizedBox(width: 20),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Provider.of<TodoProvider>(context, listen: false)
                                  .AddTodo(TodoModel(
                                      id: uuid.v1(),
                                      title: _titleInputController.text,
                                      keterangan: _ketInputController.text,
                                      tglmulai: dateStartInput.toString(),
                                      tglselesai: dateEndInput.toString(),
                                      kategetori: categoryValue,
                                      isCheck: false));

                              _titleInputController.text = '';
                              _ketInputController.text = '';
                              dateStartInput = '';
                              dateEndInput = '';
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => MyApp()));
                            },
                            child: Text("Simpan"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple,
                            ))),
                  ]),
                ),
              ],
            ),
          ],
        ));
  }
}
