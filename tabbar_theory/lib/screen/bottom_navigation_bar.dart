import 'package:flutter/material.dart';
import 'package:tabbar_theory/const/tabs.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: TABS.length, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BottomNavigationBarScreen'),
      ),
      body: TabBarView(
        controller: tabController,
        children: TABS
            .map(
              (e) => Center(
                child: Icon(e.icon),
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true, //선택된 탭 글자 보니게 할거니 ?
        showUnselectedLabels: true, // 선택하지 않은 탭 글자 보이게 할거니?
        currentIndex: tabController.index,
        // 몇번째 탭이 눌렷는지 확인
        onTap: (index) {
          tabController.animateTo(index);
        },
        type: BottomNavigationBarType.fixed, // 선택된 탭 타입을 바꿀꺼니 ?
        items: TABS
            .map((tab) =>
                BottomNavigationBarItem(icon: Icon(tab.icon), label: tab.label))
            .toList(),
      ),
    );
  }
}
