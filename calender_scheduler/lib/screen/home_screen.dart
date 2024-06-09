import 'package:calender_scheduler/component/calendar.dart';
import 'package:calender_scheduler/const/color.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? selectedDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //테이블 캘린더
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              focusedDay: DateTime(2024, 6, 1),
              onDaySelected: onDaySelected,
              selectedDayPredicate: selectedDayPredicate,
            ),
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
