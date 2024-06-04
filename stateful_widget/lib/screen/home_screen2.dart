import 'package:flutter/material.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  Color color = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                if (color == Colors.deepPurple) {
                  color = Colors.indigoAccent;
                } else {
                  color = Colors.deepPurple;
                }
                setState(() {});
              },
              child: Text("우분투 ssh 외부접속 허용설정 완료")),
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
