import 'package:flutter/material.dart';
import 'package:row_and_column/const/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //반복문 !
    List<Widget> colorBoxContainer = colors
        .map(
          (item) => Container(
            height: 50.0,
            width: 50.0,
            color: item,
          ),
        )
        .cast<Widget>()
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.center <--- 기본값
              // mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              //DRY  - Do not Repeat Yourself // 반복되는 코드는 사용하면 안된다
              children: colorBoxContainer,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  color: Colors.orange,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              //crossAxisAlignment: CrossAxisAlignment.center <--- 기본값
              // mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              //DRY  - Do not Repeat Yourself // 반복되는 코드는 사용하면 안된다
              children: colorBoxContainer,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  color: Colors.green,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
