import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          color: Colors.red,
          // 정렬될 위치를 알수 없다면 자식 위젯의 크기 설정은 무시될 수도 있다...!
          child: Align(
            // 0~1 사이 값으로 위치 설정가능
            alignment: Alignment(0, 0),
            child: Container(
              height: 50,
              width: 50,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
