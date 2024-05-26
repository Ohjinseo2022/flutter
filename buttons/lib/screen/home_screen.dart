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
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              //onPressed : null, ->> disable 처리가능
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                //배경 색깔
                backgroundColor: Colors.red,
                disabledBackgroundColor: Colors.grey,
                //배경 위의 색깔
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.red,
                // 그림자 색깔
                shadowColor: Colors.green,
                // 그림자 높이
                elevation: 10,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
                padding: EdgeInsets.all(20),
                //테두리 디자인
                side: BorderSide(
                  color: Colors.deepPurpleAccent,
                  width: 12,
                ),
                // minimumSize: Size(150, 50), // 최소 사이즈
                // maximumSize: Size(100, 150), // 최대 사이즈
                // fixedSize: Size(100, 150), //고정 사이즈
              ),
              child: Text("Elevated Button"),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text("Outlined Button"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Text Button"),
            ),
          ],
        ),
      ),
    );
  }
}
