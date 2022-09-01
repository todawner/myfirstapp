import 'package:hive/hive.dart';
part 'task_model.g.dart';//hive 세팅2
//flutter packages pub run build_runner build

//hive 세팅1

@HiveType(typeId:1)
class Task extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? note;
  @HiveField(2)
  String? creation_data;
  @HiveField(4)
  String? time;
  @HiveField(5)
  bool? done;


  Task({
    this.title,
    this.note,
    this.creation_data,
    this.time,
    this.done,
  });

}