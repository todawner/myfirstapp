
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calendar/Crazymemo/maintask.dart';

import 'package:calendar/finalcrazy/xday.dart';
import 'package:calendar/Crazymemo/task_editor.dart';
import 'package:calendar/Crazymemo/task_model.dart';


import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'excel.dart';

import 'package:intl/intl.dart';

import 'package:calendar/finalcrazy/Timer/todayreview.dart';

//main.dart


import 'package:intl/date_symbol_data_local.dart'; //캘린더한국어








late Box box;


void main() async{
  await Hive.initFlutter(); //hive 세팅1
  Hive.registerAdapter(TaskAdapter());//hive 세팅2
  box = await Hive.openBox<Task>('tasks');//hive 세팅3
  initializeDateFormatting().then((_) => runApp(GetMaterialApp(  //캘린더한국어
    home:tabpage() ,
  )));}

  //     GetMaterialApp(
  //
  //   initialRoute: '/',
  //   getPages: [
  //     GetPage(name: '/', page: () => const todaypage()),
  //     // GetPage(name: '/one', page: () => xdaypage(), arguments: {"listDate":listDate,"ListTaskTitle":ListTaskTitle,"ListTask":ListTask} ),
  //     GetPage(name: '/two', page: () => const maintasklist()),  //card 부분빼서 excellist ㄱ 그리고 삭제
  //     GetPage(name: '/three', page: () => const excellist()),
  //   ],
  // )


class tabpage extends StatefulWidget {
  const tabpage({Key? key}) : super(key: key);

  @override
  State<tabpage> createState() => _tabpageState();
}

class _tabpageState extends State<tabpage> {

  //tab bar

  int bottomSelectedIndex = 0;
  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
      BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'calendar'),
    ];
  }
//처음보여줄 페이지?
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );


  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: const <Widget>[
        todaypage(),
        //xdaypage()
        // Builder(
        //   builder: (context) {
        //     return  Get.to(()=>xdaypage(listDate,ListTaskTitle,ListTask);)
        //   }

      ],
    );
  }


  @override
  void initState() {
    super.initState();
    pageChanged;
    bottomTapped;

  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index; //0,1
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      // pageController.animateTo(
      //   0.0,
      //   duration: const Duration(milliseconds: 500),
      //   curve: Curves.easeOut,
      // );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (pageController.hasClients) {
          pageController.animateToPage(
              index, duration: const Duration(milliseconds: 500),
              curve: Curves.ease);
        }
      });
    });}



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => (TaskEditor())))},
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),

    );
  }
}








class todaypage extends StatefulWidget {
  const todaypage({Key? key}) : super(key: key);



  @override

  State<todaypage> createState() => _todaypageState();
}

class _todaypageState extends State<todaypage> {
  List<dynamic> _taskList = [];

  List<dynamic> Todaytitlelist = [] ; //?? ["복습없음"] // todo : 빈상태로 보내지면, initstate안에 넣기
  List<dynamic> Todaynotelist = [] ;
  List<dynamic> Todaytimelist = [] ;
  List<dynamic> Todaytasklist = [] ;


  List<Iterable> ListTaskTitle = [];
  List<Iterable> ListTaskNote = [];
  List<Iterable> ListTaskTime = [];
  List<Iterable> ListTask = [];
  List<dynamic> listDate =[];





  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(actions : [  IconButton(
        onPressed: () =>{Navigator.push(context, MaterialPageRoute(builder: (context) => (excellist())))},
        icon: const Icon(Icons.add),)]),
      // drawer: Drawer(
      //
      //
      //   child: ListView(
      //     // Important: Remove any padding from the ListView.
      //     padding: EdgeInsets.zero,
      //     children: [
      //       const DrawerHeader( child: Text('Drawer Header'), ),
      //
      //       ListTile(
      //         leading: const Icon(Icons.home),
      //         title: const Text('오늘'),
      //         onTap: (){
      //
      //           return Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.calendar_month),
      //         title: const Text('달력'),
      //         onTap: () {
      //           Get.toNamed('/one');
      //         }),
      //         ListTile(
      //         leading: const Icon(Icons.calendar_month),
      //         title: const Text('리스트'),
      //         onTap: () {
      //           Get.toNamed('/two');
      //         }),
      //         ListTile(
      //         leading: const Icon(Icons.light_mode),
      //         title: const Text('관리-편집,삭제'),
      //         onTap: () {
      //           Get.toNamed('/three');
      //         }),
      //
      //     ],
      //   ),
      // ),




      // 오늘 복습할것
      body:  Column(

          mainAxisAlignment: MainAxisAlignment.center,

        children: [


          Container(

              child: Column(

            children: const [
              Text('Today',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70),),
              Text('upgrade',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50),)
            ],
          )),

          // _taskList.isEmpty  작동 ㄴㄴ
          // 오늘복습할task든 뭐든 모든 task가 담긴 _taskList 안에 뭐가 있는지 암
          // 근데, _taskList.isEmpty  가 작동하지않음
          // 



          Container(
            child:
              Expanded(
                child: ValueListenableBuilder<Box<Task>>(
                    valueListenable: Hive.box<Task>("tasks").listenable(),
                    builder: (context, box, _ ) {

                      Box<Task> taskbox = Hive.box<Task>('tasks');
                      _taskList = taskbox.values.toList(); //리스트형태로 Task의 value 모두 가져오기

                      Set setDate = _taskList.map((e) => e.creation_data).toSet(); //set 이라 서로다른 날짜가져옴.
                      List<dynamic> listDate = setDate.toList(); //list로 다시바꿈.    [ "8/27/22", "8/28/22" ..... ]


                      // List<Iterable> ListTaskTitle = [];
                      // List<Iterable> ListTaskNote = [];
                      // List<Iterable> ListTaskTime = [];
                      // List<Iterable> ListTask = [];


                      for (String i in  listDate){
                      Iterable newlist = _taskList.where((e) => e.creation_data==i ); // 날짜와 같은 Task
                      Iterable newlistTitle = newlist.map((e) => e.title).toList(); // Task중에 title
                      Iterable newlistNote = newlist.map((e) => e.note).toList(); // Task중에 note
                      Iterable newlistTime = newlist.map((e) => e.time).toList(); // Task중에 time

                      ListTask.add(newlist); // 날짜와 같은 task // [["8/26/22"tasks ],["8/27/22"tasks], ... 오늘총8개 ,내일16개,.... ]

                      ListTaskTitle.add(newlistTitle); // [["8/26/22"title],["8/27/22"title] ]
                      ListTaskNote.add(newlistNote);
                      ListTaskTime.add(newlistTime);
                      }
                      final Today = DateFormat.yMd().format(DateTime.now());

                      int index = 0;



                      if ( listDate.contains(Today) == true ) { //오늘날짜가 복습할날짜냐?
                        index = listDate.indexOf(Today);

                        Todaytasklist = ListTask.elementAt(index).toList(); //오늘날짜의 task모음 // 타이머의 time을 수정하려면 오늘닐짜의 task필요
                        Todaytitlelist = ListTaskTitle.elementAt(index).toList(); //오늘날짜의 title모음
                        Todaynotelist = ListTaskNote.elementAt(index).toList();
                        Todaytimelist = ListTaskTime.elementAt(index).toList();

                      }else{
                        return const Text("오늘복습할거없슴 얏호 ");

                      }

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(onPressed:(){Get.to(()=> todayreview(Todaytasklist,Todaytitlelist,Todaynotelist,Todaytimelist));} , icon: const Icon(Icons.play_arrow_rounded)),
                              const SizedBox(width: 30,height: 30,),
                              const Icon(Icons.audiotrack_rounded,color: Colors.cyan),
                              Text("${Today}"),
                            ],
                          ),
                          Container(width: 10,height: 10,),

                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: ListTaskTitle.elementAt(index).length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [

                                    Text("${Todaytitlelist[index]}"),

                                    Container(width: 10,height: 10,),

                                  ],
                                );
                              }),
                        ],
                      );

                    })

    ))]
          ),



      );
  }
}


