import 'package:flutter/material.dart';
import 'dart:ffi';
//getx 적용후
import 'package:get/get.dart';
//hive 적용후
import 'package:hive_flutter/hive_flutter.dart';
import 'main_list_tile.dart';
import 'task_editor.dart';
import 'task_model.dart';
import 'package:hive_flutter/adapters.dart';



late Box box;

void main() async{
  await Hive.initFlutter(); //hive 세팅1
  Hive.registerAdapter(TaskAdapter());//hive 세팅2
  box = await Hive.openBox<Task>('tasks');//hive 세팅3
  return runApp(GetMaterialApp(
    home:maintasklist() ,
  ));
}

class maintasklist extends StatefulWidget {
  const maintasklist({Key? key}) : super(key: key);

  @override
  State<maintasklist> createState() => _MyAppState();
}

class _MyAppState extends State<maintasklist> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder<Box<Task>>(
          valueListenable: Hive.box<Task>("tasks").listenable(),
          builder: (context, box, _ ) {

            return ListView.builder(
                shrinkWrap: true,
                itemCount: box.values.length,
                itemBuilder: (context, index) {
                  final Task currentTask = box.getAt(index)!;
                  // print(currentTask); index0부터 index끝까지 하나하나씩 task들을 다 가져옴.



                  return MyListTile(currentTask, index); // 모든 Task 가져온것임..
                });
          }),
      bottomNavigationBar: BottomAppBar(child: IconButton(onPressed: () =>Get.to( TaskEditor()), icon: Icon(Icons.add_box_outlined)),),

    );
  }
}