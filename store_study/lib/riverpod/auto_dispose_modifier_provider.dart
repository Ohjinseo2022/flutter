import 'package:flutter_riverpod/flutter_riverpod.dart';

//autoDispose 를 빼면 기본적인 프로바이더랑 동일
//autoDispose 는 캐싱되지 않는다.
final autoDisposeModifierProvider =
    FutureProvider.autoDispose<List<int>>((ref) async {
  await Future.delayed(Duration(seconds: 2));

  return [1, 2, 3, 4, 5, 6, 7];
});
