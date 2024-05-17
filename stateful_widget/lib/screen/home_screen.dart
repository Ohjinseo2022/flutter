import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Color color = Colors.blue;
  @override
  Widget build(BuildContext context) {
    print('build 실행!!');
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              print("클릭클릭");
              if (color == Colors.blue) {
                color = Colors.red;
              } else {
                color = Colors.blue;
              }
              print("색상 변경 : color: $color");
              setState(() {}); // 이게 핵심! 빌드함수를 다시 실행하는 함수
            },
            child: Text('색깔 변경'),
          ),
          SizedBox(
            height: 32,
          ),
          Container(
            width: 50,
            height: 50,
            color: color,
          )
        ],
      ),
    );
  }
}
