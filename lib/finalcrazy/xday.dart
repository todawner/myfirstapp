import 'package:calendar/finalcrazy/ftoday.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calendar/finalcrazy/xday.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp( // Before: MaterialApp(
      home: xdaypage(),
    );
  }
}



class xdaypage extends StatefulWidget {
  const xdaypage({Key? key}) : super(key: key);
  @override
  State<xdaypage> createState() => _xdaypageState();
}

class _xdaypageState extends State<xdaypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader( child: Text('Drawer Header'), ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text('오늘'),
              onTap: ()=>{
                Get.to(() => todaypage())
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: const Text('달력'),
              onTap: () {
                return Navigator.pop(context);
              },
            ),
          ],
        ),
      ),





      // 달력
      body: const Center(
        child: Text('My Page!'),
      ),
    );
  }
}


