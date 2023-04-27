import 'dart:ffi';

import 'package:flutter/material.dart';

class CardTodo extends StatefulWidget {
  final String title;
  final String keterangan;
  final String dateStart;
  final String dateEnd;
  final String category;
  final String selectedCategory;
  final Color color;
  final bool isCheck;

  const CardTodo({
    Key? key,
    required this.title,
    required this.keterangan,
    required this.dateStart,
    required this.dateEnd,
    required this.category,
    required this.selectedCategory,
    required this.color,
    required this.isCheck,
  }) : super(key: key);

  @override
  State<CardTodo> createState() => _CardTodoState();
}

class _CardTodoState extends State<CardTodo> {
  bool isCheckedTodo = false;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      color: Colors.white,
      child: Column(
        children: [
          // widget.selectedCategory == 'null' ||
          //         widget.category == widget.selectedCategory
          //     ?
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                this.isExpanded = !isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          child: Checkbox(
                            fillColor: MaterialStatePropertyAll(widget.color),
                            checkColor: Colors.white,
                            // value: widget.isCheck,
                            value: isCheckedTodo,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedTodo = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.title}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              Text('${widget.dateStart} - ${widget.dateEnd}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 250,
                      child: Text(
                        widget.keterangan,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                isExpanded: this.isExpanded,
              ),
            ],
          )
          // : Container()
        ],
      ),
    );
  }
}
