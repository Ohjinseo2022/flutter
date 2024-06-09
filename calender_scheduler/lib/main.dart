import 'package:calender_scheduler/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  //플러터 프레임 워크가 실행될 준비가 됐는 지 확인 하는 함수.
  //원래는 따로 호출하지 않아도 동작하지만. 다른 함수를 메인 안에 동작 시킬때 충돌 방지를 위해 먼저 실행 시켜준다.
  //플러터 프레임 워크가 실행되고 나서 그다음 함수가 실행 되어야 하기 떄문임
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
