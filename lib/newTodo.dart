import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sort/model/modelTodo.dart';
import 'package:todo_sort/provider/providersTodos.dart';

class NewTodos extends StatefulWidget {
  const NewTodos({super.key});

  @override
  State<NewTodos> createState() => _NewTodosState();
}

class _NewTodosState extends State<NewTodos> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _ketInputController = TextEditingController();
  final TextEditingController _dateStartInputController =
      TextEditingController();
  final TextEditingController _dateEndInputController = TextEditingController();
  String categoryValue = 'Routine';

  @override
  Widget build(BuildContext context) {
    final List<String> listCategory = <String>['Routine', 'Work', 'Others'];
    return Scaffold(
        appBar: AppBar(
          title: Text("Todos"),
        ),
        body: Column(
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
                  controller: _titleController,
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
                    child: TextField(
                  controller: _dateStartInputController,
                  decoration: InputDecoration(
                    hintText: '20-03-2022',
                  ),
                )),
                SizedBox(width: 70),
                Expanded(
                    child: TextField(
                  controller: _dateEndInputController,
                  decoration: InputDecoration(
                    hintText: '20-03-2022',
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
                                  title: _ketInputController.text,
                                  keterangan: _ketInputController.text,
                                  tglmulai: _dateStartInputController.text,
                                  tglselesai: _dateEndInputController.text,
                                  kategetori: categoryValue));
                        },
                        child: Text("Simpan"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                        ))),
              ]),
            ),
          ],
        ));
  }
}
