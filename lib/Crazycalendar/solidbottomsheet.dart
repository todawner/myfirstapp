// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
// import 'package:get/get.dart';
//
// import 'package:calendar/Crazymemo/task_editor.dart';
// import 'package:calendar/Crazymemo/maintask.dart';
//
//
// import 'package:calendar/Crazymemo/task_model.dart';
// import 'package:calendar/Crazymemo/task_editor.dart';
// import 'package:calendar/Crazymemo/maintask.dart';
//
//
// import 'calendar.dart';
//
// import 'solidbottomsheetlist.dart';
//
//
//
// class bottomsheet extends StatefulWidget {
//   bottomsheet({Key? key}) : super(key: key);
//
//
//
//   @override
//   State<bottomsheet> createState() => _bottomsheetState();
// }
//
// class _bottomsheetState extends State<bottomsheet> {
//   @override
//   Widget build(BuildContext context) {
//     return SolidBottomSheet(
//         headerBar: Container(
//             color: Theme.of(context).primaryColor,
//             height: 50,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(onPressed: () =>Get.to( maintasklist()), icon: Icon(Icons.play_circle_outline_rounded)),
//
//               ],
//             )
//         ),
//         body : const tasklist());
//   }
// }