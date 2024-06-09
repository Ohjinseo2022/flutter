import 'package:flutter/material.dart';
import 'package:calender_scheduler/const/color.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final DateTime focusedDay;
  final OnDaySelected onDaySelected;
  final bool Function(DateTime day) selectedDayPredicate;
  const Calendar(
      {super.key,
      required this.focusedDay,
      required this.onDaySelected,
      required this.selectedDayPredicate});

  @override
  Widget build(BuildContext context) {
    final defaultBosDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        color: Colors.grey[200]!,
        width: 1.0,
      ),
    );
    final defaultTextStyle = TextStyle(
      color: Colors.grey[600],
      fontWeight: FontWeight.w700,
    );
    return TableCalendar(
      locale: 'ko_KR',
      //선택된 날짜가 아닌 내가 보여줘야할 날짜를 의미함
      focusedDay: focusedDay,
      //고를수 있는 날짜중 가장 첫번째 날짜
      firstDay: DateTime(1800),
      //고를수 있는 날짜중 가장 마지막 날짜
      lastDay: DateTime(3000),
      //헤더 스타일
      headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          )),
      calendarStyle: CalendarStyle(
        //오늘이 몇일인지 확인
        isTodayHighlighted: true,
        //무언가 스타일이나 속성을 줄때는 모든 상황에 동일하게 적용 시켜 줘야 한다. -> 애니메이션 효과떄문에 스타일에 변경을 줄땐 한땀한땀 고쳐줘야함
        defaultDecoration: defaultBosDecoration,
        weekendDecoration: defaultBosDecoration,
        selectedDecoration: defaultBosDecoration.copyWith(
          border: Border.all(
            color: primaryColor,
            width: 1,
          ),
        ),
        todayDecoration: defaultBosDecoration.copyWith(
          color: primaryColor,
        ),
        outsideDecoration: defaultBosDecoration.copyWith(
            border: Border.all(
          color: Colors.transparent, //투명
        )),
        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
        selectedTextStyle: defaultTextStyle.copyWith(
          color: primaryColor,
        ),
      ),
      onDaySelected: onDaySelected,
      selectedDayPredicate: selectedDayPredicate,
    );
  }
}
