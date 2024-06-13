import 'package:drift/drift.dart';

class CategoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get color => text()();

  // IntColumn get randomNumber => integer()();
  // 기본값 지정하는 방법
  // IntColumn get ttt => integer().withDefault(const Constant(0))();
  // null 허용
  // IntColumn get ttt => integer().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().clientDefault(() => DateTime.now().toUtc())();
}
