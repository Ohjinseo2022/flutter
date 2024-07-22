import 'package:flutter_riverpod/flutter_riverpod.dart';

//family 를 사용하게 되면 데이터를 전달 해줄수 있음 !
final familyModifierProvider = FutureProvider.family<List<int>, int>(
  (ref, data) async {
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(5, (index) => index * data);
    // return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  },
);
