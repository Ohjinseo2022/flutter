import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layoyut.dart';

class ListViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ListViewScreen',
      body: renderSeparated(),
    );
  }

  //1
  //SingleChildScrollView 와 비슷한 단점을 가짐 리스트의 모든 화면을 렌더링 시킴
  Widget renderDefault() {
    return ListView(
      children: numbers
          .map(
            (number) => renderContainer(
              color: rainbowColors[number % rainbowColors.length],
              index: number,
            ),
          )
          .toList(),
    );
  }

  //2
  // 보이는거만 렌더링해줌
  Widget renderBuilder() {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        //매번 인덱스 마다 조건에 맞게 동작함
        return renderContainer(
            color: rainbowColors[index % rainbowColors.length], index: index);
      },
    );
  }

  //3
  // 2 + 중간 중간에 조건에 맞는 위젯을 추가할 수 있음
  Widget renderSeparated() {
    return ListView.separated(
      itemCount: 100,
      itemBuilder: (context, index) {
        //매번 인덱스 마다 조건에 맞게 동작함
        return renderContainer(
            color: rainbowColors[index % rainbowColors.length], index: index);
      },
      separatorBuilder: (context, index) {
        // 광고!!!!!
        // ex) 5개의 item 마다 배너 보여 주기
        if ((index + 1) % 5 == 0) {
          return renderContainer(
              color: Colors.black, index: index + 1, height: 40);
        }
        return Container();
      },
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
