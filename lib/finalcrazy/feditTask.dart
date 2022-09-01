import 'package:flutter/material.dart';

import 'package:calendar/Crazymemo/task_editor.dart';
import 'package:calendar/Crazymemo/task_model.dart';

import 'package:flutter_slidable/flutter_slidable.dart';


import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';




class card extends StatefulWidget {
  card(this.task,this.title,this.note,{Key? key}) : super(key: key);
  Task task;
  String title;
  String note;


  @override
  State<card> createState() => _cardState();
}

class _cardState extends State<card> {
  // bool _customTileExpanded = false;

  Box<Task> taskbox = Hive.box<Task>('tasks');



  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context){

                Navigator.push(
                    context, MaterialPageRoute(builder: ((context)=>TaskEditor(task:widget.task))));
              },
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            SlidableAction(
              onPressed: (value) {

                Box<Task> taskbox = Hive.box<Task>('tasks');
                final Map<dynamic, Task> taskmap = taskbox.toMap();
                taskmap.forEach((key, value) {if(widget.task.title == value.title){
                  //todo : 정말 지우겠습니까 ? 팝업창
                  taskbox.delete(key);

                } });

                 setState(() {});


              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),]),
      child : Padding(
          padding: const EdgeInsets.all(8.0),
          child:  ExpansionTile(
            controlAffinity: ListTileControlAffinity.leading,

            title: Text("${widget.title}"), //제목
            children: [Text("${widget.note}"),],


            expandedAlignment : Alignment.centerLeft, //열었을때 위치
            // children: [
            //   Text(widget.task.note!), //내용
            // ],
            // onExpansionChanged: (bool expanded) {
            //
            //
            //   //팝업창 진짜 열거냐 ?
            //
            //
            //   // setState(() => _customTileExpanded = expanded);
            //
            // },
          )),
    );
  }
}

