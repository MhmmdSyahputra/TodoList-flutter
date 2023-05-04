import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sort/provider/providersTodos.dart';

class CardTodo extends StatefulWidget {
  final data;
  final Color color;

  const CardTodo({
    Key? key,
    required this.data,
    required this.color,
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
          // widget.data.selectedCategory == 'null' ||
          //         widget.data.category == widget.data.selectedCategory
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
                            value: widget.data.isCheck,
                            onChanged: (bool? value) {
                              if (value == true) {
                                TodoProvider todoProvider =
                                    context.read<TodoProvider>();
                                todoProvider.updateTodoStatus(
                                    widget.data.id, value!);
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.data.title}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                  '${widget.data.tglmulai.toString()} - ${widget.data.tglselesai.toString()}'),
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
                        widget.data.keterangan,
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
