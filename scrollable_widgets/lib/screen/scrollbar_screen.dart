import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layoyut.dart';

class ScrollbarScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  ScrollbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        title: "ScrollbarScreen",
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: numbers
                  .map(
                    (num) => renderContainer(
                        color: rainbowColors[num % rainbowColors.length],
                        index: num),
                  )
                  .toList(),
            ),
          ),
        ));
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
