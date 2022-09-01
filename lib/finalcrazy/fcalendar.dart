import 'package:flutter/material.dart';
//getx, hive
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
//캘린더
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:calendar/Crazymemo/task_model.dart';
import 'package:calendar/Crazycalendar/event.dart';
import 'package:flutter/foundation.dart';
//bottom
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';




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


class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  late Map<DateTime, List<Event>> selectedEvents;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }
  final dateFormat = DateFormat('EEEE yyyy-MMMM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(


        bottomSheet: SolidBottomSheet(
            draggableBody: true,
            headerBar: Container(
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(30), topRight:Radius.circular(30),),),
                child: const Center(
                child: Text("Swipe me!"),
                  ),),
             body : Text("hi!")
        ),

        body: TableCalendar(

                focusedDay: selectedDay,
                firstDay: DateTime(1990),
                lastDay: DateTime(2050),
                locale: 'ko-KR',
                eventLoader: _getEventsfromDay,
                availableGestures: AvailableGestures.all,
                onDaySelected: (DateTime selectDay, DateTime focusDay) {
                  setState(() {
                    selectedDay = selectDay;
                    focusedDay = focusDay;
                  });
                },
                calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      return selectedEvents[date] != null ? Icon(Icons.check,color: Colors.amber) : Container() ;
                    }
                ),

                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekVisible: true,

                selectedDayPredicate: (DateTime date) {
                  return isSameDay(selectedDay, date);
                },


                //UI (기능X)
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  selectedTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  weekendDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),

                headerStyle: HeaderStyle(
                  titleTextStyle: const TextStyle(fontSize: 25.0),
                  titleTextFormatter: (date, locale) => DateFormat.M(locale).format(date), // 월 만 표기. (지금이몇년도인지알게뭐람?)

                  formatButtonVisible: false,
                  titleCentered: true,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  formatButtonShowsNext: false,


                  formatButtonDecoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  formatButtonTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),



            // Container(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       IconButton(icon:const Icon(Icons.add,size: 50.0),color: Colors.blue,
            //           onPressed: (){},),
            //       IconButton(icon:const Icon(Icons.play_arrow_rounded,size: 50.0),color: Colors.blue,
            //         onPressed: (){},),
            //
            //     ],
            //   ),
            // )

        );
  }


}
