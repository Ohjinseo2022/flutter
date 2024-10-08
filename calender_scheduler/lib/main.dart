import 'package:calender_scheduler/const/color.dart';
import 'package:calender_scheduler/database/drift.dart';
import 'package:calender_scheduler/screen/home_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  //플러터 프레임 워크가 실행될 준비가 됐는 지 확인 하는 함수.
  //원래는 따로 호출하지 않아도 동작하지만. 다른 함수를 메인 안에 동작 시킬때 충돌 방지를 위해 먼저 실행 시켜준다.
  //플러터 프레임 워크가 실행되고 나서 그다음 함수가 실행 되어야 하기 떄문임
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  final dataBase = AppDatabase();
  //의존성 주입 schedule_bottom_sheet.dart 140 line 확인
  GetIt.I.registerSingleton<AppDatabase>(dataBase);
  // await dateBase.createSchedule(
  //   ScheduleTableCompanion(
  //     startTime: Value(12),
  //     endTime: Value(13),
  //     content: Value('디비테스트'),
  //     date: Value(DateTime.utc(2024, 06, 10)),
  //     color: Value(categoryColors.first),
  //   ),
  // );
  // final res = await dataBase.getSchedules();
  // print(res);
  final colors = await dataBase.getCategories();
  // colors 가 없다면
  if (colors.isEmpty) {
    for (String hexCode in categoryColors) {
      await dataBase.createCategory(
        CategoryTableCompanion(
          color: Value(hexCode),
        ),
      );
    }
  }
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: "NotoSans",
    ),
    home: HomeScreen(),
  ));
}
