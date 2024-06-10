import 'package:calender_scheduler/component/calendar.dart';
import 'package:calender_scheduler/component/custom_text_field.dart';
import 'package:calender_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calender_scheduler/component/schedule_card.dart';
import 'package:calender_scheduler/component/today_banner.dart';
import 'package:calender_scheduler/const/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (_) {
                return ScheduleBottomSheet();
              });
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //테이블 캘린더
            Calendar(
              focusedDay: focusedDay,
              onDaySelected: onDaySelected,
              selectedDayPredicate: selectedDayPredicate,
            ),
            TodayBanner(
              selectedDay: selectedDay,
              taskCount: 1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: ListView(
                  children: [
                    ScheduleCard(
                      startTime: DateTime(
                        2024,
                        06,
                        10,
                        12,
                      ),
                      endTime: DateTime(
                        2024,
                        06,
                        10,
                        18,
                      ),
                      content: "회사에서 공부하기",
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onDaySelected(selectedDay, focusedDay) {
    print(selectedDay);
    print(focusedDay);
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = focusedDay;
    });
  }

  bool selectedDayPredicate(DateTime day) {
    // 날짜가 선택된 날짜로 마킹해줄지 결정해주는 함수
    // print('--------');
    // print("선택한 날짜: " + day.toString());
    // print("비교할 날짜: " + this.selectedDay.toString());
    // flutter: 선택한 날짜: 2024-07-06 00:00:00.000Z
    // flutter: 비교할 날짜: 2024-06-12 00:00:00.000
    // 타임존 확인 필요
    if (this.selectedDay == null) {
      return false;
    } else {
      return day.isAtSameMomentAs(this.selectedDay!);
    }
  }
}
