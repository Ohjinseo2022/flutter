import 'package:flutter/material.dart';
import 'package:navigation/screen/home_screen.dart';
import 'package:navigation/screen/route_one_screen.dart';
import 'package:navigation/screen/route_three_screen.dart';
import 'package:navigation/screen/route_two_screen.dart';

// Imperactive vs Declaractive
void main() {
  runApp(
    MaterialApp(
      //초기 라우트 변경가능
      initialRoute: "/",
      // home: HomeScreen(),
      routes: {
        //key - 라우트 이름
        //value - builder -> 이동하고 싶은 라우트
        '/': (BuildContext context) => HomeScreen(),
        '/one': (BuildContext context) => RouteOneScreen(number: 999),
        '/two': (BuildContext context) => RouteTwoScreen(),
        '/three': (BuildContext context) => RouteThreeScreen(),
      },
    ),
  );
}
