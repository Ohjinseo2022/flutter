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
      // backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // gradient: RadialGradient(
          //   //원형 그라데이션
          //   center: Alignment.center, // 그라데이션 시작 위치
          //   radius: 0.5,
          //   colors: [
          //     Colors.red,
          //     Colors.green,
          //   ],
          // ),
          gradient: LinearGradient(
            //1자 그라데이션
            begin: Alignment.topCenter, //시작 기준
            end: Alignment.bottomCenter, // 종료 기준
            // stops: [
            //   // 색깔의 비중 색깔의 갯수만큼 리스트 주가 가능
            //   0.5,
            //   0.8,
            // ],
            colors: [
              Color(0xFF2A3A7C),
              Color(0xFF000118),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _logo(),
            SizedBox(
              height: 28,
            ),
            _Title(),
          ],
        ),
      ),
    );
  }
}

class _logo extends StatelessWidget {
  const _logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "asset/image/logo.png",
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 32.0,
      fontWeight: FontWeight.w300,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "VIDEO",
          style: textStyle,
        ),
        Text(
          "PLAYER",
          //기존에 입력된 값들을 그대로 가져온다. 이미 존재하는 값들은 덮어 쓰기가된다.
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
