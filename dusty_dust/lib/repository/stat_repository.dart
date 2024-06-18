import 'package:dio/dio.dart';

class StatRepository {
  static Future<Map<String, dynamic>> fetchData() async {
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
        'itemCode': 'PM10',
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );
    print(serviceKey);
    print(response.data);
    return response.data;
  }
}
