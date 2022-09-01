import 'package:flutter/material.dart';
import 'task_model.dart';
import 'task_editor.dart';

import 'package:flutter_slidable/flutter_slidable.dart';


class MyListTile extends StatefulWidget {
  MyListTile(this.task,this.index,{Key? key}) : super(key: key);
  Task task;
  int index;

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  // bool _customTileExpanded = false;


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

                widget.task.delete();

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

            title: Text( widget.task.title!), //제목
            subtitle: Text(  widget.task.creation_data!),//날짜
            expandedAlignment : Alignment.centerLeft, //열었을때 위치
            children: [
              Text(widget.task.note!), //내용
            ],
            onExpansionChanged: (bool expanded) {


              //팝업창


              // setState(() => _customTileExpanded = expanded);

            },
          )),
    );
  }
}

