import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_study/riverpod/provider_observer.dart';
import 'package:store_study/screen/home_screen.dart';

void main() {
  runApp(
    //ProviderScope 를 추가해줘야 상태관리 툴을 사용할수있음
    ProviderScope(
      //로깅 하는 방법
      observers: [Logger()],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    ),
  );
}
