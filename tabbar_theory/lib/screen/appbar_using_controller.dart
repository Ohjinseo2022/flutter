import 'package:flutter/material.dart';
import 'package:tabbar_theory/const/tabs.dart';

class AppbarUsingController extends StatefulWidget {
  const AppbarUsingController({super.key});

  @override
  State<AppbarUsingController> createState() => _AppbarUsingControllerState();
}

//                                                                       프레임당 틱이 움직이는걸 효율적으로 컨트롤할수 있게 해줌
class _AppbarUsingControllerState extends State<AppbarUsingController>
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
        title: Text('AppbarUsingController'),
        bottom: TabBar(
          controller: tabController,
          tabs: TABS
              .map((e) => Tab(
                    icon: Icon(e.icon),
                    child: Text(e.label),
                  ))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: TABS
            .map((e) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(e.icon),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (tabController.index != 0)
                          ElevatedButton(
                              onPressed: () {
                                if (tabController.index != 0) {
                                  tabController
                                      .animateTo(tabController.index - 1);
                                }
                              },
                              child: Text('이전')),
                        if (tabController.index != 0 &&
                            tabController.index != TABS.length - 1)
                          SizedBox(
                            width: 16,
                          ),
                        if (tabController.index != TABS.length - 1)
                          ElevatedButton(
                              onPressed: () {
                                if (tabController.index != TABS.length - 1) {
                                  tabController
                                      .animateTo(tabController.index + 1);
                                }
                              },
                              child: Text('다음')),
                      ],
                    )
                  ],
                ))
            .toList(),
      ),
    );
  }
}
