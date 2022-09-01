
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
//getx 적용후
import 'package:get/get.dart';
//hive 적용후
import 'package:hive_flutter/hive_flutter.dart';
import 'package:calendar/Crazymemo/task_model.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:calendar/finalcrazy/Timer/timer.dart';



class TodayReview extends StatefulWidget {
  TodayReview(this.task,this.title,this.note,this.time,{Key? key}) : super(key: key);
  dynamic task;
  dynamic title;
  dynamic note;
  dynamic time;



  @override
  State<TodayReview> createState() => _TodayReviewState();
}

class _TodayReviewState extends State<TodayReview> {
  bool isFront = true; //초기값은 앞면







  @override




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [

            Container(
              width: Get.width/2,
              height: Get.width/2,
              child: Card(child: timer(widget.task)),
            ),

           Container(
             child: SafeArea(
                  child: Center(
                    child:
                    GestureDetector(

                      onTap: (){
                        setState(() {
                          if (isFront){
                            isFront = false;
                          }
                          else{isFront = true;}

                        });
                      },
                      child: Container(
                          width: 300,
                          height: 300,
                          child: isFront
                              ?  Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.amberAccent
                              ),
                              child: Center(child: Text(widget.title)))
                              :  Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.lightBlueAccent
                              ),
                              child: Center(child: Text(widget.note)))

                      ),),


                  ),
              ),
           ),
          ],
        ),
      ));
  }
}
