import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layoyut.dart';

class GridViewScreen extends StatelessWidget {
  List<int> numbers = List.generate(100, (index) => index);
  GridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "GridViewScreen",
      // 기본 constrector 는 CustomScrollView 를 사용한게 아니라면 일반적으론 사용할일이 없음
      body: renderMaxExtent(),
    );
  }

  //1
  //한번에 다그림
  Widget renderCount() {
    return GridView.count(
      //List 전체를 렌더링 하는 위젯이기 때문에 퍼포먼스가 중요한 화면에서 쓰기엔 문제가 있다.
      //스크롤 형태의 view는 위에서 아래로 가는게 mainAxis 라고 봄
      //crossAxisCount 좌에서 우의 갯수
      crossAxisCount: 2,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      children: numbers
          .map((number) => renderContainer(
              color: rainbowColors[number % rainbowColors.length],
              index: number))
          .toList(),
    );
  }

  //2
  // 보이는거만 그림
  Widget renderBuilderCrossAxisCount() {
    return GridView.builder(
      //필수 파라미터 GridView 의 생성 조건을 넣어주는 부분
      //Sliver
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ), //
      itemBuilder: (context, index) {
        return renderContainer(
            color: rainbowColors[index % rainbowColors.length], index: index);
      }, // ListView 와 동일
      itemCount: numbers.length, // 이거 없으면 무한 스크롤링됨 !
    );
  }

  //3
  // 최대 사이즈
  Widget renderMaxExtent() {
    return GridView.builder(
      //필수 파라미터 GridView 의 생성 조건을 넣어주는 부분
      //Sliver
      gridDelegate:
          SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 100), //
      itemBuilder: (context, index) {
        return renderContainer(
            color: rainbowColors[index % rainbowColors.length], index: index);
      }, // ListView 와 동일
      itemCount: numbers.length, // 이거 없으면 무한 스크롤링됨 !
    );
  }

  Widget renderContainer(
      {required Color color, required int index, double? height}) {
    print(index);

    return Container(
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          '$index',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
