import 'package:flutter/material.dart';
import 'package:scrollable_widgets/layout/main_layoyut.dart';

class GridViewScreen extends StatelessWidget {
  const GridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "GridViewScreen",
      // 기본 constrector 는 CustomScrollView 를 사용한게 아니라면 일반적으론 사용할일이 없음
      body: GridView.count(
        //스크롤 형태의 view는 위에서 아래로 가는게 mainAxis 라고 봄
        //crossAxisCount 좌에서 우의 갯수
        crossAxisCount: 2,
      ),
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
