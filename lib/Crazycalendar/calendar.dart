import 'package:calendar/Crazycalendar/solidbottomsheetlist.dart';

import 'event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'solidbottomsheet.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';



//title 변수가져와야함. 그래서 여기서 bottomsheet 넣기
import 'package:calendar/Crazymemo/task_editor.dart';


//
import 'package:get/get.dart';
import 'package:calendar/Crazymemo/maintask.dart';



class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Map<DateTime, List<Event>> selectedEvents;
  // CalendarFormat format = CalendarFormat.month;
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

  save ()=>{
    if (_eventController.text.isEmpty) {

    } else {
      if (selectedEvents[selectedDay] != null) {
        selectedEvents[selectedDay]!.add(
          Event(title: _eventController.text),
        )
      } else {
        selectedEvents[selectedDay] = [
          Event(title: _eventController.text)
        ]
      }

    }
    // _eventController.clear();
    // setState((){});
    // return;
  };






  @override
  Widget build(BuildContext context) {
    return Scaffold(

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Add Event"),
              content: TextFormField(
                controller: _eventController,
              ),
              actions: [
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    save();
                    Navigator.of(context, rootNavigator: true).pop();
                    _eventController.clear();
                    setState((){});
                  },
                ),
              ],
            ),
          ),
          label: Text("Add Event"),
          icon: Icon(Icons.add),
        ),
      bottomSheet: SolidBottomSheet(
              headerBar: Container(
              color: Theme.of(context).primaryColor,
              height: 50,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  IconButton(onPressed: () =>
                      Get.to(() => maintasklist(), arguments: save()),
                      icon: Icon(Icons.play_circle_outline_rounded)),],)),
              body : const tasklist()
      ),


      //          ..._getEventsfromDay(selectedDay).map(
      //                 (Event event) => ListTile(
      //               title: Text(
      //                 event.title,
      //               ),
      //             ),
      //           ),


      body: TableCalendar(
        focusedDay: selectedDay,
        firstDay: DateTime(1990),
        lastDay: DateTime(2050),
        locale: 'ko-KR',
        // calendarFormat: format,
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

          onFormatChanged: (CalendarFormat _format) {
            setState(() {
              // format = _format;
            });
          },
          startingDayOfWeek: StartingDayOfWeek.monday,
          daysOfWeekVisible: true,

          selectedDayPredicate: (DateTime date) {
            return isSameDay(selectedDay, date);
          },



        calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),
            selectedTextStyle: TextStyle(color: Colors.white),
            todayDecoration: BoxDecoration(
              color: Colors.purpleAccent,
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
      ));

  }

}