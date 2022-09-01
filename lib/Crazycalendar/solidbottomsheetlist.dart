import 'package:flutter/material.dart';
import 'dart:ffi';
//getx 적용후
import 'package:get/get.dart';
//hive 적용후
import 'package:hive_flutter/hive_flutter.dart';
import 'package:calendar/Crazymemo/main_list_tile.dart';
import 'package:calendar/Crazymemo/task_editor.dart';
import 'package:calendar/Crazymemo/task_model.dart';
import 'package:hive_flutter/adapters.dart';


late Box box;

void main() async{
  await Hive.initFlutter(); //hive 세팅1
  Hive.registerAdapter(TaskAdapter());//hive 세팅2
  box = await Hive.openBox<Task>('tasks');//hive 세팅3
  return runApp(GetMaterialApp(
    home:tasklist() ,
  ));
}

class tasklist extends StatefulWidget {
  const tasklist({Key? key}) : super(key: key);

  @override
  State<tasklist> createState() => _MyAppState();
}

class _MyAppState extends State<tasklist> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder<Box<Task>>(
          valueListenable: Hive.box<Task>("tasks").listenable(),
          builder: (context, box, _) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: box.values.length,
                itemBuilder: (context, index) {
                  final Task currentTask = box.getAt(index)!;
                  return MyListTile(currentTask, index);
                });
          }),
      bottomNavigationBar: BottomAppBar(child: IconButton(onPressed: () =>Get.to( TaskEditor()), icon: Icon(Icons.add_box_outlined)),),

    );
  }
}
