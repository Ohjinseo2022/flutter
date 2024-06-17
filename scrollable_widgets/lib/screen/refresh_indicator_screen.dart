import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layoyut.dart';

class RefreshIndicatorScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  RefreshIndicatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'RefreshIndicatorScreen',
      body: RefreshIndicator(
        onRefresh: () async {
          // 실제론 서버 요청이 들어감
          await Future.delayed(Duration(seconds: 3));
        },
        backgroundColor: Colors.white.withOpacity(0.1),
        child: ListView(
          children: numbers
              .map(
                (idx) => renderContainer(
                    color: rainbowColors[idx % rainbowColors.length],
                    index: idx),
              )
              .toList(),
        ),
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
