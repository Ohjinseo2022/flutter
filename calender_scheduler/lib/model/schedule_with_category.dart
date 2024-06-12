import 'package:calender_scheduler/database/drift.dart';

// 스프링에서 커스텀 DTO 느낌
class ScheduleWithCategory {
  final CategoryTableData categoryTable;
  final ScheduleTableData scheduleTable;
  ScheduleWithCategory(
      {required this.categoryTable, required this.scheduleTable});
}
