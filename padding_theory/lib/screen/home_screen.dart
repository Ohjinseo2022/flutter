import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.red,
          child: Padding(
            // padding: const EdgeInsets.all(32.0),
            // padding: const EdgeInsets.symmetric(horizontal: 32.0), //좌우 대칭
            // padding: const EdgeInsets.symmetric(vertical: 32.0), //상하 대칭
            // padding: const EdgeInsets.only(
            //   top: 32,
            //   left: 40,
            //   right: 16,
            //   bottom: 120,
            // ),
            padding: const EdgeInsets.fromLTRB(
              32,
              64,
              16,
              8,
            ), // only 와 마찬가지로 직접 설정 가능
            child: Container(
              color: Colors.blue,
              width: 50.0,
              height: 50.0,
            ),
          ),
        ),
      ),
    );
  }
}
