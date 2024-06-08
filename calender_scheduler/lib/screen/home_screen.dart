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
        child: TableCalendar(
          //선택된 날짜가 아닌 내가 보여줘야할 날짜를 의미함
          focusedDay: DateTime(2024, 6, 1),
          //고를수 있는 날짜중 가장 첫번째 날짜
          firstDay: DateTime(1800),
          //고를수 있는 날짜중 가장 마지막 날짜
          lastDay: DateTime(3000),
          onDaySelected: (selectedDay, focusedDay) {
            print(selectedDay);
            print(focusedDay);
            setState(() {
              this.selectedDay = selectedDay;
            });
          },
          selectedDayPredicate: (DateTime day) {
            // 날짜가 선택된 날짜로 마킹해줄지 결정해주는 함수
            print('--------');
            print("선택한 날짜: " + day.toString());
            print("비교할 날짜: " + this.selectedDay.toString());
            // flutter: 선택한 날짜: 2024-07-06 00:00:00.000Z
            // flutter: 비교할 날짜: 2024-06-12 00:00:00.000
            // 타임존이다름
            if (this.selectedDay == null) {
              return false;
            } else {
              return day.isAtSameMomentAs(this.selectedDay!);
            }
          },
        ),
      ),
    );
  }
}
