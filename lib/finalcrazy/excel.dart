import 'package:calendar/Crazycalendar/solidbottomsheetlist.dart';
import 'package:flutter/material.dart';
import 'dart:ffi';
//getx 적용후
import 'package:get/get.dart';
//hive 적용후
import 'package:hive_flutter/hive_flutter.dart';

import 'package:calendar/Crazymemo/task_editor.dart';
import 'package:calendar/Crazymemo/task_model.dart';
import 'package:hive_flutter/adapters.dart';

import 'feditTask.dart';



late Box box;

void main() async{
  await Hive.initFlutter(); //hive 세팅1
  Hive.registerAdapter(TaskAdapter());//hive 세팅2
  box = await Hive.openBox<Task>('tasks');//hive 세팅3
  return runApp(GetMaterialApp(
    home:excellist() ,
  ));
}


class excellist extends StatefulWidget {
  const excellist({Key? key}) : super(key: key);

  @override
  State<excellist> createState() => _excellistState();
}

class _excellistState extends State<excellist> {


  List<dynamic> _taskList = [];


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder<Box<Task>>(
          valueListenable: Hive.box<Task>("tasks").listenable(),

          builder: (context, box, _ ) {

            Box<Task> taskbox = Hive.box<Task>('tasks');
            List<Task> _taskList = taskbox.values.toList(); //리스트형태로 Task의 value 모두 가져오기

            Set setDate = _taskList.map((e) => e.creation_data).toSet(); //set 이라 서로다른 날짜가져옴.
            List<dynamic> listDate = setDate.toList(); //list로 다시바꿈.    [ "8/27/22", "8/28/22" ..... ]
            //listDate.reversed;


            List<List<Task>> ListTask = [];
            List<List<String?>> ListTaskTitle = [];
            List<List<String?>> ListTaskNote = [];


            for (String i in  listDate){

              List<Task> newlist = _taskList.where((e) => e.creation_data==i ).toList(); // 날짜가 같은 Task, 어제만들었든 1달전에 만들었던 복습날짜creationdata가 같은 task


              List<String?> newlistTitle = newlist.map((e) => e.title).toList(); // Task중에 title
              List<String?> newlistNote = newlist.map((e) => e.note).toList(); // Task중에 note
              ListTaskTitle.add(newlistTitle); // [["8/26/22"title],["8/27/22"title] ]
              ListTaskNote.add(newlistNote); // [["8/26/22"note],["8/27/22"note] ]

              ListTask.add(newlist); // [["8/26/22"tasks ],["8/27/22"tasks], ... 오늘총8개 ,내일16개,.... ]

            }



            return ListView.builder(
                shrinkWrap: true,
                itemCount: ListTask.length, //8개인데, 인덱스하나안의 요소가 다 사라지면
                itemBuilder: (context, index) {
                  List<String?> a = ListTaskTitle[index].toList();
                  List<String?> c = ListTaskNote[index].toList();
                  List<Task> b = ListTask[index].toList();


                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.audiotrack_rounded,color: Colors.cyan),
                          Text("${listDate[index]}"),
                        ],
                      ),
                      Container(width: 10,height: 10,),

                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: b.length,
                        itemBuilder: (context, i) {
                          return card(b[i],a[i]!, c[i]!);
                        }
                      ),

                      Container(width: 10,height: 10,),

                    ],
                  );
                });
          }),
      bottomNavigationBar: BottomAppBar(child: IconButton(onPressed: () =>Get.to( TaskEditor()), icon: Icon(Icons.add_box_outlined)),),

    );
  }
}






      // //map으로 돌리면서 key와 value print
      // newList!.forEach((e) { e.forEach((key, value) {
      //
      //   Container(
      //     child: Column(
      //       children: [
      //         Text("복습할날짜 = ${key}"),
      //         value.forEach((element) { })
      //         SizedBox(
      //           child: Column(
      //             children: [
      //             ],
      //           ),
      //         )
      //
      //       ],
      //     ),
      //   )
      // })})

