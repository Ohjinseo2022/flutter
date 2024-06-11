import 'package:calender_scheduler/component/calendar.dart';
import 'package:calender_scheduler/component/custom_text_field.dart';
import 'package:calender_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calender_scheduler/component/schedule_card.dart';
import 'package:calender_scheduler/component/today_banner.dart';
import 'package:calender_scheduler/const/color.dart';
import 'package:calender_scheduler/model/schedule.dart';
import 'package:flutter/material.dart';
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

  /// {
  ///  2023-11-23 : [Schedule,Schedule,Schedule,...],
  ///  2023-11-24 : [Schedule,Schedule,Schedule,...],
  /// }
  Map<DateTime, List<ScheduleTable>> schedules = {
    // DateTime.utc(2024, 6, 10): [
    //   ScheduleTable(
    //     id: 1,
    //     startTime: 11,
    //     endTime: 12,
    //     content: '플러터강의 몇개 안남음 나이스',
    //     date: DateTime.utc(2024, 6, 10),
    //     color: categoryColors.first,
    //     createdAt: DateTime.now().toUtc(),
    //   ),
    //   ScheduleTable(
    //     id: 2,
    //     startTime: 13,
    //     endTime: 16,
    //     content: 'CI/CD 개념정리',
    //     date: DateTime.utc(2024, 6, 10),
    //     color: categoryColors[3],
    //     createdAt: DateTime.now().toUtc(),
    //   ),
    // ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response = await showModalBottomSheet(
              context: context,
              builder: (_) {
                return ScheduleBottomSheet(selectedDay: selectedDay);
              });
          if (response == null) {
            return;
          }
          //기본적인 방법
          setState(() {
            schedules = {
              //1)
              //기존 스케줄이 저장된 Map 을 그대로 복사
              ...schedules,
              //response.date을 키값으로 가진 새로운 Map 값 생성 or 기존 키에 접근
              response.date: [
                //기존에 키가 있다면 해당 키값이 가지고있는 value 그대로 복사,
                if (schedules.containsKey(response.date))
                  ...schedules[response.date]!,
                //제일 마지막에 새로운 value 저장
                response,
              ]
            };
            //2)
            //기존 스케쥴이 있는지 확인
            // final dateExists = schedules.containsKey(response.date);
            // //있다면 기존스케줄을 그대로 복사
            // final List<Schedule> existingSchedules =
            //     dateExists ? schedules[response.date]! : [];
            // //제일 마지막 인덱스에 입력받은 스케줄 추가
            // existingSchedules.add(response);
            // schedules = {...schedules, response.date: existingSchedules};
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
                // LazyLoading
                child: ListView.separated(
                  //ListView.builder
                  //화면에 보여줄 아이템의 갯수
                  itemCount: schedules.containsKey(selectedDay)
                      ? schedules[selectedDay]!.length
                      : 0,
                  itemBuilder: (context, index) {
                    //해당 영역이 화면에 보일때 해당 함수가 실행 되어 위젯을 반환 해줌
                    //List<Schedule>
                    final scheduleModel = schedules[selectedDay]![index];
                    print(index);
                    // return ScheduleCard(
                    //   startTime: scheduleModel.startTime,
                    //   endTime: scheduleModel.endTime,
                    //   content: scheduleModel.content,
                    //   color: Color(
                    //     int.parse(
                    //       'FF${scheduleModel.color}',
                    //       radix: 16,
                    //     ),
                    //   ),
                    // );
                  },
                  //itemBuilder 가 실행될때 separatorBuilder 도 같이 실행할수 있다.
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 8.0,
                    );
                  },
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
