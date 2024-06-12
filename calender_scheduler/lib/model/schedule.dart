import 'package:calender_scheduler/model/category.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

class ScheduleTable extends Table {
  /// 1) 식별 가능한 ID
  // final int id;
  IntColumn get id => integer().autoIncrement()();

  /// 2) 시작 시간
  // final int startTime;
  IntColumn get startTime => integer()();

  /// 3) 종료 시간
  // final int endTime;
  IntColumn get endTime => integer()();

  /// 4) 일정 내용
  // final String content;
  TextColumn get content => text()();

  /// 5) 날짜
  // final DateTime date;
  DateTimeColumn get date => dateTime()();

  /// 6) 카테고리
  // final String color;
  // TextColumn get color => text()();
  IntColumn get colorId =>
      integer().references(CategoryTable, #id)(); // 다른데이블 연결

  /// 7) 일정 생성날짜 시간
  // final DateTime createdAt;
  // row 가 생성될때마다 현재시간으로 자동 입력 들어가게 할거임!!
  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();

  // Schedule({
  //   required this.id,
  //   required this.startTime,
  //   required this.endTime,
  //   required this.content,
  //   required this.date,
  //   required this.color,
  //   required this.createdAt,
  // });
}
