// import 'package:flutter/material.dart';
//
// import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/date_symbol_data_local.dart'; // 한국어
//
// // 고정 : 만들기+복습하기> (만든게없으면 아이콘없애기)
// // 더 위로 당기기 : 뭘 복습할건지 제목으로 보여주고, 누르면 개별 보기 가능.
//
// void main() {
//   initializeDateFormatting().then((_) => runApp(MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'TableCalendar Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: StartPage(),
//     );
//   }
// }
//
//
//
//
// class StartPage extends StatefulWidget {
//   @override
//   _StartPageState createState() => _StartPageState();
// }
//
// class _StartPageState extends State<StartPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TableCalendar Example'),
//       ),
//
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 20.0),
//             ElevatedButton(
//               child: Text('Basics'),
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => TableBasicsExample())
//               ),
//             ),
//             const SizedBox(height: 12.0),
//           ]
//         ),
//       ),
//     );
//   }
// }
//
//
// class TableBasicsExample extends StatefulWidget {
//   @override
//   _TableBasicsExampleState createState() => _TableBasicsExampleState();
// }
//
// class _TableBasicsExampleState extends State<TableBasicsExample> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // bottomNavigationBar: ,
//
//
//
//       appBar: AppBar(
//         title: Text('TableCalendar - Basics'),
//       ),
//       body: TableCalendar(
//         locale: 'ko-KR',
//         firstDay: DateTime.utc(2021, 10, 16),
//         lastDay: DateTime.utc(2023, 12, 31),
//         focusedDay: _focusedDay,
//         calendarFormat: _calendarFormat,
//         daysOfWeekHeight:50,
//
//
//         headerStyle: const HeaderStyle(
//           formatButtonVisible: false,
//           titleCentered: true,
//           leftChevronVisible: false,
//           rightChevronVisible: false
//         ),
//
//         calendarStyle : const CalendarStyle( //todo : todayTextStyle,selectedTextStyle 둘다 둥근꼴말고 둥근사각꼴로 ㄱ
//           todayTextStyle: TextStyle(fontSize:20, color: Colors.white, fontWeight: FontWeight.bold, ),
//           selectedTextStyle: TextStyle(fontSize:20, color: Colors.white, fontWeight: FontWeight.bold)
//         ),
//
//
//         selectedDayPredicate: (day) {
//           // Use `selectedDayPredicate` to determine which day is currently selected.
//           // If this returns true, then `day` will be marked as selected.
//
//           // Using `isSameDay` is recommended to disregard
//           // the time-part of compared DateTime objects.
//           return isSameDay(_selectedDay, day);
//
//         },
//
//
//         onDaySelected: (selectedDay, focusedDay) {
//           if (!isSameDay(_selectedDay, selectedDay)) {
//             // Call `setState()` when updating the selected day
//             setState(() {
//               _selectedDay = selectedDay;
//               _focusedDay = focusedDay;
//             });
//           }
//         },
//
//         onPageChanged: (focusedDay) {
//           // No need to call `setState()` here
//           _focusedDay = focusedDay;
//         },
//         // Enable week numbers (disabled by default).
//
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

//https://github.com/dbenitez-bcn/solid_bottom_sheet/issues
// 깃허브 이슈 - 잘되면 말고 안되면 아래따라하기
// https://www.youtube.com/watch?v=84OuUPoO8ng&ab_channel=JohannesMilke

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomSheet: SolidBottomSheet(
        headerBar: Container(
          color: Theme.of(context).primaryColor,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.add)),
              IconButton(onPressed: (){}, icon: Icon(Icons.add ))
              ],
            )
          ),
        body: Container(
          color: Colors.white,
          height: 30,
          child: Center(
            child: Text(
              "Hello! I'm a bottom sheet :D",
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
      ),
    );
  }
}