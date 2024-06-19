import 'package:isar/isar.dart';

part 'stat_model.g.dart';

//{"daegu": "26", "chungnam": "29", "incheon": "28","daejeon": "30",
// "gyeongbuk": "30","sejong": "27","gwangju": "33","jeonbuk": "37",
// "gangwon": "24","ulsan": "42","jeonnam": "23","seoul": "25",
// "busan": "35","jeju": "26","chungbuk": "28","gyeongnam": "27",
// "gyeonggi": "29",}
enum Region {
  daegu,
  chungnam,
  incheon,
  daejeon,
  gyeongbuk,
  sejong,
  gwangju,
  jeonbuk,
  gangwon,
  ulsan,
  jeonnam,
  seoul,
  busan,
  jeju,
  chungbuk,
  gyeongnam,
  gyeonggi;

  String get krName {
    switch (this) {
      case Region.daegu:
        return '대구';
      case Region.chungnam:
        return '충남';
      case Region.incheon:
        return '인천';
      case Region.daejeon:
        return '대전';
      case Region.gyeongbuk:
        return '경북';
      case Region.sejong:
        return '세종';
      case Region.gwangju:
        return '광주';
      case Region.jeonbuk:
        return '전북';
      case Region.gangwon:
        return '강원';
      case Region.ulsan:
        return '울산';
      case Region.jeonnam:
        return '전남';
      case Region.seoul:
        return '서울';
      case Region.busan:
        return '부산';
      case Region.jeju:
        return '제주';
      case Region.chungbuk:
        return '충북';
      case Region.gyeongnam:
        return '경냠';
      case Region.gyeonggi:
        return '경기';
      default:
        throw Exception('존재 하지 않는 지역이름 입니다');
    }
  }
}

enum ItemCode {
  SO2,
  CO,
  O3,
  NO2,
  PM10,
  PM25;

  String get krName {
    switch (this) {
      case ItemCode.SO2:
        return '이황산가스';
      case ItemCode.CO:
        return '일산화탄소';
      case ItemCode.O3:
        return '오존';
      case ItemCode.NO2:
        return '이산화질소';
      case ItemCode.PM10:
        return '미세먼지';
      case ItemCode.PM25:
        return '초미세먼지';
      default:
        throw Exception('존재하지 않는 코드입니다.');
    }
  }
}

//isar -> noSql
//테이블을 콜렉션이라고 부름
// 특정 칼럼을 유니크하게 만들수 있음 !
@collection
class StatModel {
  Id id = Isar.autoIncrement;
  //지역
  @enumerated
  //중복된 데이터가 입력되지 않게 제한해놓음
  @Index(unique: true, composite: [
    CompositeIndex('dateTime'),
    CompositeIndex('itemCode'),
  ])
  late Region region;
  //통계 값
  late double stat;
  //날짜
  late DateTime dateTime;
  // 미세먼지 / 초미세먼지
  @enumerated
  late ItemCode itemCode;
}
