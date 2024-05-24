import 'package:flutter/material.dart';
import 'package:random_number/component/number_to_image.dart';
import 'package:random_number/constant/color.dart';
import 'dart:math';

import 'package:random_number/screen/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> numbers = [
    123,
    456,
    789,
  ];
  int maxNumber = 1000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //제목과 아이콘 버튼이 있는곳
              _Header(onPressed: goSettingScreen),
              //숫자 영역
              _Body(numbers: numbers),
              //하단 버튼
              _Footer(onPressed: createNumbers),
            ],
          ),
        ),
      ),
    );
  }

  void createNumbers() {
    final rand = Random();

    final Set<int> newNumbers = {};

    while (newNumbers.length < 3) {
      final randomNumber = rand.nextInt(maxNumber);
      newNumbers.add(randomNumber);
    }

    setState(() {
      numbers = newNumbers.toList();
    });
  }

  void goSettingScreen() async {
    print('페이지 이동해야해');
    // statefulWidget 클래스 내부에서 사용하는 context 는
    // build함수에서 제공해주는 context와 같다.(전역 적으로 사용 가능 하다)
    // context 에서는 widgetTree 의 Stack 정보를 가지고있음.
    // 페이지 이동후 돌아오면 pop()에서 전달받은 값을 리턴받아 올수 있음
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        //모든 builder 는 첫번째 매개변수로 BuildContext를 받게된다.
        builder: (BuildContext context) {
          //이동하고 싶은 페이지를 위젯으로 반환.
          return SettingScreen(
            maxNumber: maxNumber,
          );
        },
      ),
    );
    print('result : ${result}');
    maxNumber = result;
    createNumbers();
  }
}

class _Header extends StatefulWidget {
  final VoidCallback? onPressed;
  const _Header({required this.onPressed, super.key});

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "랜덤숫자 생성기",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          onPressed: widget.onPressed,
          iconSize: 20,
          icon: Icon(Icons.settings),
          color: redColor,
        ),
      ],
    );
  }
}

class _Body extends StatefulWidget {
  final List<int> numbers;
  const _Body({required this.numbers, super.key});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // 내풀이
        // children: [1, 4, 7]
        //     .map((startNum) => Row(
        //           children:
        //               ['${startNum}', '${startNum + 1}', '${startNum + 2}']
        //                   .map((strNum) => Text(
        //                         strNum,
        //                         style: TextStyle(color: Colors.white),
        //                       ))
        //                   .toList(),
        //         ))
        //     .toList()),
        //강의 자료
        children: widget.numbers
            .map((arr) => NumberToImage(
                  number: arr,
                ))
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback? onPressed;
  const _Footer({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '생성하기',
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: redColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
