import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layoyut.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  // 쉽게 리스트를 생성하는 Dart 내부함수
  final List<int> numbers = List.generate(100, (index) => index);
  SingleChildScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "SingleChildScrollView",
      //SingleChildScrollView 로 감싸고 있는 요소를 스크롤 할 수 있게 해줌
      body: renderPerformance(),
    );
  }

  //1)
  //기본 랜더링 방법
  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors
            .map(
              (color) => renderContainer(color: color),
            )
            .toList(),
      ),
    );
  }

  //2)
  // 화면을 넘어가지 않아도 스크롱 가능하게 하기
  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(), //스크롤 안됨
      physics: AlwaysScrollableScrollPhysics(), //언제든지 스크롤 동작 시켜라
      child: Column(
        children: [renderContainer(color: Colors.black)],
      ),
    );
  }

  //3)
  //스크롤시 위젯이 변형되지 않게 하기
  Widget renderClip() {
    return SingleChildScrollView(
      //스크롤시 하위 위젯들의 동작방식
      clipBehavior: Clip.none,
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [renderContainer(color: Colors.black)],
      ),
    );
  }

  //4)
  //여러가지 physics 정리
  Widget renderPhysics() {
    return SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(), //스크롤 안됨
      // physics: AlwaysScrollableScrollPhysics(), //언제든지 스크롤 동작 시켜라
      // physics: BouncingScrollPhysics(), // iso 스타일의 스크롤 애니매이션
      physics: ClampingScrollPhysics(), // Android 스타일
      child: Column(
        children: rainbowColors
            .map(
              (color) => renderContainer(color: color),
            )
            .toList(),
      ),
    );
  }

  //5
  // SingleChildScrollView 퍼포먼스
  Widget renderPerformance() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: numbers
            .map((number) => renderContainer(
                color: rainbowColors[number % rainbowColors.length],
                index: number))
            .toList(),
      ),
    );
  }

  Widget renderContainer({required Color color, int? index}) {
    if (index != null) {
      print(index);
    }
    return Container(
      height: 300,
      color: color,
      child: index != null
          ? Center(
              child: Text(
                '$index',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
            )
          : null,
    );
  }
}
