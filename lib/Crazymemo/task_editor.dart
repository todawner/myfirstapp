import 'package:calendar/Crazycalendar/solidbottomsheetlist.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'task_model.dart';

//getx 적용후
import 'package:get/get.dart';

//ftoday.dart 이동
import 'package:calendar/finalcrazy/ftoday.dart';


//지금까지 한거
// 처음 작성당시 저장된정보가 담긴 task 가져옴
// task 안에는 title,note,creation_data 담김
// 이제 할것
// 복습날짜 만들기, 오늘복습할 메모의 title 만들기



class TitleEvent {
  final String title;
  TitleEvent({required this.title});

  String toString() => this.title;
}


//    final Controller getcontroller = Get.put(Controller());



class TaskEditor extends StatefulWidget {
  TaskEditor({this.task, Key? key}) : super(key: key);
  Task? task;

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {

  List<Task> _taskList = [];

  updatereview(selectTask,newtitle,newnote) async{
    Box<Task> taskbox = Hive.box<Task>('tasks');
      //수정하는곳
      //날짜만update안함 = 수정해도 전에 저장된 날짜 그대로 저장된다.

    //title이 같은 Task들 중에 하나가 수정했다면,

    _taskList = taskbox.values.toList(); //리스트형태로 Task모두 가져오기
    //title이 같은 Task들을 부르기
    List filterList = _taskList.where((item) => item.title == selectTask.title ).toList();

    // 그후 모두 수정(filterList= selectTask, title같은Task들)
    // 기존의것들을 새로만든것들 (newtitle,newnote)로 교체

    filterList.forEach((e) {
      e.title = newtitle;
      e.note = newnote;
      widget.task!.save();
    });

  }


  @override


  Widget build(BuildContext context) {
    TextEditingController _taskTitle = TextEditingController(
        text: widget.task == null ? null : widget.task!.title!);
    TextEditingController _tasknote = TextEditingController(
        text: widget.task == null ? null : widget.task!.note!);



    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading:
          IconButton(
          icon: Icon(Icons.arrow_back_ios),

          onPressed: () async {


            Box<Task> taskbox = Hive.box<Task>('tasks');

            if (widget.task != null) {

              updatereview(widget.task,_taskTitle.text,_tasknote.text);

              Get.toNamed('/', arguments:[widget.task!.creation_data!]);

            }

            else {
            //저장버튼 누르면 -> 그날날짜 +1,2,5,7,15,30,60,120도 똑같이 복사
            var now = new DateTime.now();
            // var review1 = now.add(new Duration(days: 1));
            var review1 = now;
            var review2 = now.add(new Duration(days: 2));
            var review5 = now.add(new Duration(days: 5));
            var review7 = now.add(new Duration(days: 7));
            var review15 = now.add(new Duration(days: 15));
            var review30 = now.add(new Duration(days: 30));
            var review60 = now.add(new Duration(days: 60));
            var review120 = now.add(new Duration(days: 120));

            var newTask1 = Task(
                title: _taskTitle.text,
                note: _tasknote.text,
                creation_data:DateFormat.yMd().format(review1),
                time: "0",
                done: false
            );
            var newTask2 = Task(
                title: _taskTitle.text,
                note: _tasknote.text,
                creation_data:DateFormat.yMd().format(review2),
                time: "0",
                done: false
            ); var newTask5 = Task(
                title: _taskTitle.text,
                note: _tasknote.text,
                creation_data:DateFormat.yMd().format(review5),
                time: "0",
                done: false
            ); var newTask7 = Task(
                title: _taskTitle.text,
                note: _tasknote.text,
                creation_data:DateFormat.yMd().format(review7),
                time: "0",
                done: false
            ); var newTask15 = Task(
                title: _taskTitle.text,
                note: _tasknote.text,
                creation_data:DateFormat.yMd().format(review15),
                time: "0",
                done: false
            ); var newTask30 = Task(
                title: _taskTitle.text,
                note: _tasknote.text,
                creation_data:DateFormat.yMd().format(review30),
                time: "0",
                done: false
            ); var newTask60 = Task(
                title: _taskTitle.text,
                note: _tasknote.text,
                creation_data:DateFormat.yMd().format(review60),
                time: "0",
                done: false
            ); var newTask120 = Task(
                title: _taskTitle.text,
                note: _tasknote.text,
                creation_data:DateFormat.yMd().format(review120),
                time: "0",
                done: false
            );

            await taskbox.add(newTask1);
            await taskbox.add(newTask2);
            await taskbox.add(newTask5);
            await taskbox.add(newTask7);
            await taskbox.add(newTask15);
            await taskbox.add(newTask30);
            await taskbox.add(newTask60);
            await taskbox.add(newTask120);



            //reviewX.title
            Get.toNamed('/' ,arguments: [newTask1.creation_data]);

          }}

        )),
        body: ListView(
          children: [
            TextFormField(
                controller: _taskTitle,
                maxLines: null,
                style: TextStyle(fontSize: 30,
                    fontWeight: FontWeight.w200,
                    color: Colors.black),
                decoration: InputDecoration(
                  hintText: "제목없음",
                  contentPadding: EdgeInsets.fromLTRB(30, 0, 0, 40),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,)

            ),
            TextFormField(
              controller: _tasknote,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "여기를 탭하여 입력을 시작하세요",
                contentPadding: EdgeInsets.fromLTRB(30, 0, 0, 40),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,),
            ),
            Container(height: Get.height, color: Colors.white,)
          ],
        )
    );
  }

}
