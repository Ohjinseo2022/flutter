import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layoyut.dart';

class CustomScrollViewScreen extends StatefulWidget {
  const CustomScrollViewScreen({super.key});

  @override
  State<CustomScrollViewScreen> createState() => _CustomScrollViewScreenState();
}

class _CustomScrollViewScreenState extends State<CustomScrollViewScreen> {
  final List<int> numbers = List.generate(100, (index) => index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('CustomScrollViewScreen'),
          ),
          renderBuilderSliverList(),
        ],
      ),
      // Column(
      //   children: [
      //     // 컬럼안에서 사용할땐 Expanded 로 감싸야함
      //     Expanded(
      //       child: ListView(
      //         children: rainbowColors
      //             .map((color) => renderContainer(color: color, index: 1))
      //             .toList(),
      //       ),
      //     ),
      //     Expanded(
      //       child: GridView.count(
      //         crossAxisCount: 2,
      //         children: rainbowColors
      //             .map((color) => renderContainer(color: color, index: 1))
      //             .toList(),
      //       ),
      //     )
      //   ],
      // ),
    );
  }

  // ListView 기본 생성자와 유사함.
  SliverList renderChildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (num) => renderContainer(
                  color: rainbowColors[num % rainbowColors.length], index: num),
            )
            .toList(),
      ),
    );
  }

  //ListView.builder 생성자와 유사함.
  SliverList renderBuilderSliverList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        return renderContainer(
            color: rainbowColors[index % rainbowColors.length], index: index);
      },
      childCount: 100,
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
