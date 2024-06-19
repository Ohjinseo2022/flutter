import 'package:dio/dio.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class StatRepository {
  static Future<void> fetchData() async {
    for (ItemCode itemCode in ItemCode.values) {
      final isar = GetIt.I<Isar>();
      final now = DateTime.now();
      final compareDateTimeTarget =
          DateTime(now.year, now.month, now.day, now.hour);
      final count = await isar.statModels
          .filter()
          .dateTimeEqualTo(compareDateTimeTarget)
          .count();
      if (count > 0) {
        print('데이터가 존재합니다. : count : $count');
        return;
      }
      await fetchDataByItemCode(itemCode: itemCode);
    }
  }

  static Future<List<StatModel>> fetchDataByItemCode(
      {required ItemCode itemCode}) async {
    final String serviceKey =
        'kOJAY3KurAEo/hEj4YcZnn6qdCVMy1cK4gbZj3px7ccRheXfX0jvXXRi3Cl8w2K9JXaO89/0hpndUpKXKdTUtA==';
    //Dio 에서 자동으로 인코딩처리를 해주기떄문에 디코딩된 키를 넣어야한다
    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        "serviceKey": serviceKey,
        'returnType': 'json',
        'numOfRows': 100,
        'pageNo': 1,
        'itemCode': itemCode.name,
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );
    final rawItemsList =
        response.data['response']['body']['items'] as List<dynamic>;
    // rawItemsList.map((item){
    //
    // }).toList();
    List<StatModel> stats = [];
    final List<String> skipKeys = ['dataGubun', 'dataTime', 'itemCode'];
    for (Map<String, dynamic> item in rawItemsList) {
      final dataTime = DateTime.parse(item['dataTime']);
      for (String key in item.keys.toList()) {
        final regionStr = key;
        if (!(skipKeys.contains(key))) {
          final region =
              Region.values.firstWhere((element) => element.name == regionStr);
          final stat = double.parse(item[key]);
          final statModel = StatModel()
            ..region = region
            ..stat = stat
            ..dateTime = dataTime
            ..itemCode = itemCode;
          final isar = GetIt.I<Isar>();

          final count = await isar.statModels
              .filter()
              .regionEqualTo(region)
              .dateTimeEqualTo(dataTime)
              .itemCodeEqualTo(itemCode)
              .count();
          if (count > 0) {
            continue;
          }
          await isar.writeTxn(
            () async {
              await isar.statModels.put(statModel);
            },
          );
          // stats = [
          //   ...stats,
          //   StatModel(
          //     region:
          //         //key : 'daegu' -> Region.daegu
          //         Region.values
          //             .firstWhere((element) => element.name == regionStr),
          //     stat: double.parse(stat),
          //     dateTime: DateTime.parse(dataTime),
          //     itemCode: itemCode,
          //   )
          // ];
        }
      }
    }
    return stats;
  }
}
