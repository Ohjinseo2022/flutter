import 'dart:io';

import 'package:calender_scheduler/const/color.dart';
import 'package:calender_scheduler/model/category.dart';
import 'package:calender_scheduler/model/schedule_with_category.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

import 'package:calender_scheduler/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';

//Code Generation
//완전히 다른 파일을 하나의 파일로 인식 시켜준다.

//루트 경로에서 터미널 실행 입력 dart run build_runner build
part 'drift.g.dart'; //-> 어노테이션을 기반으로 해당 파일이 자동으로 생성될수있게 도와줌

//어노테이션 테이블 생성시 리스트형태로 넣어주면된당!
@DriftDatabase(tables: [ScheduleTable, CategoryTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  //Code Generation 완료후
  // 쿼리 작성 !
  // ScheduleTableData -> 우리가 생성한적 없지만 제네레이터가 알아서 만들어줌
  // Table 정의 후 실제 사용은 TableData 형태로 가져와서 사용하게 된다
  //js 에서 Promise 가 Dart 에서 Future 라고 보면됨
  //단순 조회방법
  Future<List<ScheduleTableData>> getSchedules(DateTime date) {
    //                            . 은 실행한 결과값! .. 은 실행한 대상을 반환
    return (select(scheduleTable)..where((tbl) => tbl.date.equals(date))).get();
    // 밑에 세줄 동일
    // final selectQuery = select(scheduleTable);
    // //select * from ScheduleTable where date = {date} 느낌 ?
    // selectQuery.where((table) => table.date.equals(date));
    // return selectQuery.get();
  }

  //변화를 감지하여 계속받아온다 ?
  Stream<List<ScheduleWithCategory>> getStreamSchedules(DateTime date) {
    //                            . 은 실행한 결과값! .. 은 실행한 대상을 반환
    // return (select(scheduleTable)
    //       ..where((tbl) => tbl.date.equals(date))
    //       ..orderBy([
    //         //정렬 기준 정리
    //         (t) =>
    //             OrderingTerm(expression: t.startTime, mode: OrderingMode.asc),
    //         (t) => OrderingTerm(expression: t.endTime, mode: OrderingMode.asc),
    //       ]))
    //     .watch();
    final query = select(scheduleTable).join(
      [
        innerJoin(
          categoryTable,
          categoryTable.id.equalsExp(scheduleTable.colorId),
        ),
      ],
    )..where(scheduleTable.date.equals(date));
    return query.map((row) {
      final schedule = row.readTable(scheduleTable);
      final category = row.readTable(categoryTable);
      return ScheduleWithCategory(
          categoryTable: category, scheduleTable: schedule);
    }).watch();
  }

  //create 이후엔 우리가 지정해놓은 PK 값이 반환돤다. 현재 프로젝트에선 id-> int 형태임
  //Companion 업데이트나 생성할때 사용
  Future<int> createSchedule(ScheduleTableCompanion data) =>
      into(scheduleTable).insert(data);

  Future<int> removeSchedule(int id) =>
      (delete(scheduleTable)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> updateScheduleById(int id, ScheduleTableCompanion data) =>
      //새로 입력한 데이터를 받아와서 id 정보로 조회, 데이터 업데이트 처리
      (update(scheduleTable)
            ..where(
              (tbl) => tbl.id.equals(id),
            ))
          .write(data);
  Future<ScheduleWithCategory> getScheduleById(int id) {
    final query = (select(scheduleTable).join(
      [
        innerJoin(
          categoryTable,
          categoryTable.id.equalsExp(scheduleTable.colorId),
        )
      ],
    )..where(scheduleTable.id.equals(id)));

    return query.map((row) {
      final schedule = row.readTable(scheduleTable);
      final category = row.readTable(categoryTable);
      return ScheduleWithCategory(
          categoryTable: category, scheduleTable: schedule);
    }).getSingle();

    // return (select(scheduleTable)..where((tbl) => tbl.id.equals(id)))
    //     .getSingle(); //하나만 가져오는 방법
  }

  // 카테고리 테이블 조회
  Future<List<CategoryTableData>> getCategories() =>
      select(categoryTable).get();

  Future<int> createCategory(CategoryTableCompanion data) =>
      into(categoryTable).insert(data);

  @override
  int get schemaVersion => 1;

  // 마이그레이션 하는 간단한 방법!
  // @override
  // MigrationStrategy get migration {
  //   return MigrationStrategy(
  //     onUpgrade: (Migrator m, int from, int to) async {
  //       //m 마이그레이션에 필요한 기능 제공
  //       //from 기존 사용자의 기기에 깔려있는 버전
  //       //to 새로 마이그레이션(업데이트) 할 목표버전
  //       //특정 버전에 맞게 계속 추가해줘야ㅏㅁ!
  //       if (from < 2) {
  //         await m.addColumn(categoryTable, categoryTable.randomNumber);
  //       }
  //       if (from < 3) {
  //         await m.addColumn(categoryTable, categoryTable.randomNumber2);
  //       }
  //     },
  //   );
  // }
}

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      // 앱설치시 앱별로 배정이되는 폴더를 가져오는 기능
      final dbFolder = await getApplicationDocumentsDirectory();
      //p.join(part1) -> 다양한 운영체제에 맞게 다양한 경로들을 합쳐준다
      // /User/test/...~~~/db.sqlite 요런 느낌 -> 운영체제 형식에 맞게 합쳐줌
      final file = File(
        p.join(dbFolder.path, 'db.sqlite'),
      ); // 앱 개발은 dart.io 에서 불러와야함!!!!
      if (Platform.isAndroid) {
        //옛날 안드로이드 버전에서 버그가 있기때문에 안드로이드일 경우 해당 함수를 무조건 실행하게 돼있음!
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }
      //임시 폴더
      final cacheBase = await getTemporaryDirectory();
      // sqlite 가 임시폴더를 사용하여 캐시데이터를 저장함
      sqlite3.tempDirectory = cacheBase.path;
      // 해당 위치에 데이터 베이스를 생성해준다.!
      return NativeDatabase.createInBackground(file);
    },
  );
}
