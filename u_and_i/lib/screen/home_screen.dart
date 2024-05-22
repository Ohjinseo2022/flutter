import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectDate = DateTime(2024, 05, 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: SafeArea(
        top: true, //기본값
        bottom: false,
        child: SizedBox(
          //미디어 쿼리 사용법
          //MediaQuery.of(context).size.width => 현재 화면의 너비를 가지고 올수 있음
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              // 텍스트 영역
              _Top(
                selectDate: selectDate,
                onPressed: onIconPressed,
              ),
              // 이미지
              _Bottom(),
            ],
          ),
        ),
      ),
    );
  }

  void onIconPressed() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        /*
         정렬되는곳의 위치를 알수 없다면
         아무리 크기를 지정해줘도 화면 전체를 차지하게 된다!
      */
        return Align(
          alignment: Alignment.center,
          child: Container(
            color: Colors.white,
            height: 300,
            width: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectDate,
              maximumDate: DateTime.now(),
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  selectDate = date;
                });
              },
              dateOrder: DatePickerDateOrder.ymd,
            ),
          ),
        );
      },
    );
  }
}

class _Top extends StatelessWidget {
  final DateTime selectDate;
  final VoidCallback? onPressed;
  const _Top({
    required this.selectDate,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Text(
              'Fullter',
              style: textTheme.displayLarge,
            ),
            Text(
              "플러터 강의 시작 날 부터",
              style: textTheme.bodyLarge,
            ),
            Text(
              '${selectDate.year}.${selectDate.month}.${selectDate.day}',
              style: textTheme.bodyMedium,
            ),
            IconButton(
              iconSize: 60.0,
              color: Colors.red[200],
              onPressed: onPressed,
              icon: Icon(Icons.fact_check),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "D${now.difference(selectDate).inDays >= 0 ? '+${now.difference(selectDate).inDays + 1}' : now.difference(selectDate).inDays + 1}",
                  style: textTheme.displayMedium,
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.blue[400],
                  size: 45,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Image.asset(
          'asset/img/middle_image.png',
        ),
      ),
    );
  }
}
