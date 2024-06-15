import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layoyut.dart';

//다양한 곳에 사용할수 있게 유연성잇는 코드를 만들어야한다.
class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final child;
  final double maxHeight;
  final double minHeight;
  _SliverFixedHeaderDelegate(
      {required this.child, required this.maxHeight, required this.minHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    //dalegate 를 만들었을때 헤더를 어떻게 생성할지 정하는 빌더 함수
    return SizedBox.expand(child: child);
  }

  //최대높이
  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeight;
  //최소높이
  @override
  // TODO: implement minExtent
  double get minExtent => minHeight;

  //covariant 상송된 클래스도 사용가능하다 라는 뜻 covariant SliverPersistentHeaderDelegate
  // oldDelegate - build가 샐행됐을때 이전 Delegate
  // this - 새로운 Delegate
  // shouldRebuild - 새로 build 를 해야할지 말지를 판단 해줌 true or false 를 리턴
  // false 면 build 안함 true 면 다시 build 함
  @override
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return oldDelegate.maxHeight != maxHeight ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.child != child; //
  }
}

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
        //slivers 라는 파라미터 안에는 무조건 Sliver로 시작하는 위젯을 사용해야 한다.
        slivers: [
          renderSliverAppBar(),
          //이친구는 클래스를 직접 구현해줘야함
          renderHeader(),
          renderSliverGridBuilder(),
          renderHeader(),
          renderChildSliverList(),
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

  SliverPersistentHeader renderHeader() {
    return SliverPersistentHeader(
      //스크를을 내려도 최소 사이즈 만큼 쌓이는 효과
      pinned: true,
      delegate: _SliverFixedHeaderDelegate(
          child: Container(
            color: Colors.indigo,
            child: Center(
              child: Text('싱기하다.'),
            ),
          ),
          maxHeight: 150.0,
          minHeight: 75.0),
    );
  }

  //AppBar
  SliverAppBar renderSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.purple,
      //floating 의 기본갑은 false
      //스크롤시 앱바가 사라지는건 기본기능
      //하지만 살짝 스크롤을 위로 스크롤 하면 앱바가 다시 나오게 할지 말지 정할 수 있음
      floating: true,
      //pinned 기본값 false
      // 스크롤을 해도 앱바가 그대로 남아 있을지 여부를 정할수 있음
      pinned: false,
      //snap
      //앱바 애니매이션이 실행되면 끝가지 실행시키는 옵션
      //floating true && pinned false 상태 일때만 정상적으로 동작 확인 가능
      snap: true, // false 상태로하면 중간에 멈춤가능
      //stretch 기본 값 false
      // true 일땐 위로 올리는 스크롤을 최대로 했을때 앱바가 늘러나는 효과를 볼수있다.
      // 뒤에 빈하면이 보이지 않게하는 효과
      // 안드로이드에선 ㄱㅊ
      stretch: true,
      //앱바가 차지 하는 크기
      expandedHeight: 200,
      // 앱바가 사라지기 시작하는 크기를 정할수 있다.
      collapsedHeight: 150,
      //앱바 안에 위젯을 넣고 싶을떄 사용!
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'asset/img/image_1.jpeg',
          fit: BoxFit.cover,
        ),
        title: Text('FlexibleSpaceBar'),
      ),
      title: Text('CustomScrollViewScreen'),
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

  //GridView.count 와 유사함
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(numbers
          .map((num) => renderContainer(
              color: rainbowColors[num % rainbowColors.length], index: num))
          .toList()),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  //GridView.builder 와 유사함
  SliverGrid renderSliverGridBuilder() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
          (context, index) => renderContainer(
                color: rainbowColors[index % rainbowColors.length],
                index: index,
              ),
          childCount: 100),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
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
