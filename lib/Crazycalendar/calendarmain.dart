import 'calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//hive 적용후
import 'package:hive_flutter/hive_flutter.dart';
import 'package:calendar/Crazymemo/task_model.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:intl/date_symbol_data_local.dart'; //캘린더한국어


late Box box;

void main() async{
  await Hive.initFlutter(); //hive 세팅1
  Hive.registerAdapter(TaskAdapter());//hive 세팅2
  box = await Hive.openBox<Task>('tasks');//hive 세팅3
  initializeDateFormatting().then((_) => runApp(GetMaterialApp(  //캘린더한국어
  home:MyApp() ,
  )));}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ESTech Calendar",
      home: Calendar(),
    );
  }
}