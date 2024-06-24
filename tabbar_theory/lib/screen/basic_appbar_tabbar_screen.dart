import 'package:flutter/material.dart';
import 'package:tabbar_theory/const/tabs.dart';

class BasicAppbarTabBarScreen extends StatefulWidget {
  const BasicAppbarTabBarScreen({super.key});

  @override
  State<BasicAppbarTabBarScreen> createState() =>
      _BasicAppbarTabBarScreenState();
}

class _BasicAppbarTabBarScreenState extends State<BasicAppbarTabBarScreen> {
  @override
  Widget build(BuildContext context) {
    //DefaultTabController -> 컨트롤러 자동주입
    return DefaultTabController(
      length: TABS.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('BasicAppbarTabBarScreen'),
          //탭바를 만들수 있음
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TabBar(
                  //탭바를 사용하면 컨트롤러를 주입해줘야함
                  indicatorColor: Colors.red,
                  indicatorWeight: 1.0,
                  indicatorSize: TabBarIndicatorSize.tab,
                  isScrollable: true, //스크롤 유무
                  labelColor: Colors.purple,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w100,
                  ),
                  tabs: TABS
                      .map(
                        (e) => Tab(
                          icon: Icon(e.icon),
                          child: Text(e.label.toString()),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(), // 좌우 애니매이션 끄기
          children: TABS
              .map((e) => Center(
                    child: Icon(e.icon),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
