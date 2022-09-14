// import 'package:calendar/finalcrazy/ftoday.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
//
// import 'package:calendar/Crazycalendar/solidbottomsheetlist.dart';
//
//
// import 'package:calendar/Crazycalendar/event.dart';
//
// import 'package:table_calendar/table_calendar.dart';
//
// import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
//
//
// import 'package:get/get.dart';
// import 'package:calendar/Crazymemo/maintask.dart';
//
//
// //getx 적용후
// import 'package:get/get.dart';
// //hive 적용후
// import 'package:hive_flutter/hive_flutter.dart';
//
// import 'package:calendar/Crazymemo/task_model.dart';
// import 'package:hive_flutter/adapters.dart';
//
// import 'feditTask.dart';
//
//
//
// import 'package:intl/intl.dart';
//
//
//
//
// late Box box;
//
// void main() async{
//   await Hive.initFlutter(); //hive 세팅1
//   Hive.registerAdapter(TaskAdapter());//hive 세팅2
//   box = await Hive.openBox<Task>('tasks');//hive 세팅3
//   return runApp(GetMaterialApp(
//     home:xdaypage() ,
//   ));
// }
//
//
//
//
// // class xdaypage extends StatefulWidget {
// //   xdaypage(this.listDate,this.ListTaskTitle,this.ListTask,{Key? key}) : super(key: key);
// //   List<dynamic> listDate;
// //   List<Iterable> ListTaskTitle;
// //   List<Iterable> ListTask;
//
// class xdaypage extends StatefulWidget {
//  const xdaypage({Key? key}) : super(key: key);
//
//
//   @override
//   State<xdaypage> createState() => _xdaypageState();
// }
//
// class _xdaypageState extends State<xdaypage> {
//
//   Map<DateTime, List<Event>> selectedEvents ={};
//
//   Box<Task> taskbox = Hive.box<Task>('tasks');
//   late dynamic taskList = taskbox.values.toList(); //리스트형태로 Task의 value 모두 가져오기
//
//   late Set setDate = taskList.map((e) => e.creation_data).toSet(); //set 이라 서로다른 날짜가져옴.
//   late List<dynamic> listDate = setDate.toList(); //list로
//
//
//
//
//   DateTime selectedDay = DateTime.parse(DateFormat.yMd().format(DateTime.now()));
//   DateTime focusedDay = DateTime.parse(DateFormat.yMd().format(DateTime.now()));
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     selectedEvents= {};
//
//
//     for (dynamic i in listDate) {
//       Iterable newlist = taskList.where((e) => e.creation_data == i); // 날짜가 같은 task //DateFormat.yMd().format( DateTime.now();),
//       print(DateTime.parse(i));
//       Iterable newlistTitle = newlist.map((e) => e.title).toList(); }// Task중에 title
//       // print(newlistTitle);
//       // for (String t in newlistTitle) {
//       //   selectedEvents[DateTime.parse(i)]!.add(Event(title: t));
//       // }
//
//     print(selectedEvents);
//
//   }
//
//   @override
//   void setState(VoidCallback fn) {
//     // TODO: implement setState
//     super.setState(fn);
//     selectedEvents;
//   }
//
//
//
//
//
//     mark(){
//       return selectedEvents[0] != null ? Icon(Icons.check,color: Colors.amber) : Container() ;
//     }
//
//
//
//
//
//
//     List<Event> _getEventsfromDay(DateTime date) {
//       return selectedEvents[date] ?? [];
//       //반환값이 리스트다. 리스트안에 값이 있다면, marker가 표시된다.
//     }
//
//
//
//     // task
//     List<dynamic> _taskList = [];
//
//     List<dynamic> Todaytitlelist = [
//     ]; //?? ["복습없음"] // todo : 빈상태로 보내지면, initstate안에 넣기
//     List<dynamic> Todaynotelist = [];
//     List<dynamic> Todaytimelist = [];
//     List<dynamic> Todaytasklist = [];
//
//
//     List<Iterable> ListTaskTitle = [];
//     List<Iterable> ListTaskNote = [];
//     List<Iterable> ListTaskTime = [];
//     List<Iterable> ListTask = [];
//     // List<dynamic> listDate =[];
//
//
//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//
//           // bottomSheet: SolidBottomSheet(
//           //     headerBar: Container(
//           //         color: Theme.of(context).primaryColor,
//           //         height: Get.height/3,
//           //         child: Row(
//           //           mainAxisAlignment: MainAxisAlignment.center,
//           //           children: [
//           //             IconButton(onPressed: () =>
//           //                 Get.to(() => maintasklist(), arguments: save()),
//           //                 icon: Icon(Icons.play_circle_outline_rounded)),],)),
//           //     body : const tasklist()
//           // ),
//
//           // ..._getEventsfromDay(selectedDay).map(
//           //        (Event event) => ListTile(
//           //      title: Text(
//           //        event.title,
//           //      ),
//           //    ),
//           //  ),
//
//
//           body: Column(
//             children: [
//           ValueListenableBuilder<Box<Task>>(
//           valueListenable: Hive.box<Task>("tasks").listenable(),
//                 builder: (context, box, _ )  {
//                   return Card(
//                     // padding: const EdgeInsets.all(30),
//                     //  height: Get.height/2,
//                     child: TableCalendar(
//                       focusedDay: selectedDay,
//                       firstDay: DateTime(1990),
//                       lastDay: DateTime(2050),
//                       locale: 'ko-KR',
//                       eventLoader: _getEventsfromDay,
//                       availableGestures: AvailableGestures.all,
//                       onDaySelected: (DateTime selectDay, DateTime focusDay) {
//                         setState(() {
//                           selectedDay = selectDay;
//                           focusedDay = focusDay;
//                         });
//                       },
//                       calendarBuilders: CalendarBuilders(
//
//                           markerBuilder: (context, dateTime, events) {
//                           mark();
//
//                           }
//
//
//
//                             // return listDate.contains(date) != null ? Icon(Icons.check,color: Colors.amber) : Container() ;
//                             // return selectedEvents[date] != null ? Icon(Icons.check,color: Colors.amber) : Container() ;
//
//                       ),
//
//                       onFormatChanged: (CalendarFormat _format) {
//                         setState(() {
//                           // format = _format;
//                         });
//                       },
//                       startingDayOfWeek: StartingDayOfWeek.monday,
//                       daysOfWeekVisible: true,
//
//                       selectedDayPredicate: (DateTime date) {
//                         return isSameDay(selectedDay, date);
//                       },
//
//
//                       calendarStyle: CalendarStyle(
//                         isTodayHighlighted: true,
//                         selectedDecoration: BoxDecoration(
//                           color: Colors.blue,
//                           shape: BoxShape.rectangle,
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                         selectedTextStyle: TextStyle(color: Colors.white),
//                         todayDecoration: BoxDecoration(
//                           color: Colors.purpleAccent,
//                           shape: BoxShape.rectangle,
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                         defaultDecoration: BoxDecoration(
//                           shape: BoxShape.rectangle,
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                         weekendDecoration: BoxDecoration(
//                           shape: BoxShape.rectangle,
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                       ),
//
//                       headerStyle: HeaderStyle(
//                         formatButtonVisible: false,
//                         titleCentered: true,
//                         leftChevronVisible: false,
//                         rightChevronVisible: false,
//                         formatButtonShowsNext: false,
//
//                         formatButtonDecoration: BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                         formatButtonTextStyle: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//               ),
//
//               // Container(
//               //   child: ValueListenableBuilder<Box<Task>>(
//               //       valueListenable: Hive.box<Task>("tasks").listenable(),
//               //
//               //       builder: (context, box, _) {
//               //         Box<Task> taskbox = Hive.box<Task>('tasks');
//               //         _taskList =
//               //             taskbox.values.toList(); //리스트형태로 Task의 value 모두 가져오기
//               //
//               //         Set setDate = _taskList.map((e) => e.creation_data)
//               //             .toSet(); //set 이라 서로다른 날짜가져옴.
//               //         List<dynamic> listDate = setDate
//               //             .toList(); //list로 다시바꿈.    [ "8/27/22", "8/28/22" ..... ]
//               //
//               //
//               //         // List<Iterable> ListTaskTitle = [];
//               //         // List<Iterable> ListTaskNote = [];
//               //         // List<Iterable> ListTaskTime = [];
//               //         // List<Iterable> ListTask = [];
//               //
//               //
//               //         //selectedEvents[DateTime]!.add( Event(title: _eventController.text),)
//               //         // selectedEvents[ <1> ]!.add(Event(title: <2> ),)
//               //
//               //
//               //         for (String i in listDate) {
//               //           Iterable newlist = _taskList.where((e) =>
//               //           e.creation_data == i); // 날짜와 같은 Task
//               //           Iterable newlistTitle = newlist.map((e) => e.title)
//               //               .toList(); // Task중에 title
//               //
//               //           Iterable newlistNote = newlist.map((e) => e.note)
//               //               .toList(); // Task중에 note
//               //           Iterable newlistTime = newlist.map((e) => e.time)
//               //               .toList(); // Task중에 time
//               //
//               //           ListTask.add(
//               //               newlist); // 날짜와 같은 task // [["8/26/22"tasks ],["8/27/22"tasks], ... 오늘총8개 ,내일16개,.... ]
//               //
//               //           ListTaskTitle.add(newlistTitle); // [["8/26/22"title],["8/27/22"title] ]
//               //           ListTaskNote.add(newlistNote);
//               //           ListTaskTime.add(newlistTime);
//               //
//               //           // for (String t in newlistTitle ){
//               //           //   selectedEvents[DateTime.parse(i)]!.add( Event(title:t));
//               //           // } //달력 체크
//               //           //
//               //
//               //
//               //         }
//               //         final Today = DateFormat.yMd().format(DateTime.now());
//               //
//               //         int index = 0;
//               //
//               //
//               //         if (listDate.contains(Today) == true) { //오늘날짜가 복습할날짜냐?
//               //           index = listDate.indexOf(Today);
//               //
//               //           Todaytasklist = ListTask.elementAt(index)
//               //               .toList(); //오늘날짜의 task모음 // 타이머의 time을 수정하려면 오늘닐짜의 task필요
//               //           Todaytitlelist = ListTaskTitle.elementAt(index)
//               //               .toList(); //오늘날짜의 title모음
//               //           Todaynotelist = ListTaskNote.elementAt(index).toList();
//               //           Todaytimelist = ListTaskTime.elementAt(index).toList();
//               //         } else {
//               //           return const Text(" 복습할거없슴 얏호 ");
//               //         }
//               //
//               //         return Expanded(
//               //           child: ListView.builder(
//               //               shrinkWrap: true,
//               //               itemCount: ListTask.length,
//               //               //8개인데, 인덱스하나안의 요소가 다 사라지면
//               //               itemBuilder: (context, index) {
//               //                 List a = ListTaskTitle[index].toList();
//               //                 List b = ListTask[index].toList();
//               //                 List c = ListTaskNote[index].toList();
//               //
//               //
//               //                 return Column(
//               //                   children: [
//               //                     Row(
//               //                       mainAxisAlignment: MainAxisAlignment.center,
//               //                       children: [
//               //                         Icon(Icons.audiotrack_rounded,
//               //                             color: Colors.cyan),
//               //                         Text("${listDate[index]}"),
//               //                       ],
//               //                     ),
//               //                     Container(width: 10, height: 10,),
//               //
//               //                     ListView.builder(
//               //                         shrinkWrap: true,
//               //                         itemCount: b.length,
//               //                         itemBuilder: (context, i) {
//               //                           return card(b[i], a[i]!, c[i]!);
//               //                         }
//               //                     ),
//               //
//               //                     Container(width: 10, height: 10,),
//               //
//               //                   ],
//               //                 );
//               //               }),
//               //         );
//               //       }),
//               // )
//
//
//             ],
//           ));
//     }
//   }
//
//
//
//
