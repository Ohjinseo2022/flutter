import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_study/layout/default_layout.dart';
import 'package:store_study/riverpod/listen_provider.dart';

//StatefulWidget 의 모든기능을 가진 친구
class ListenProviderScreen extends ConsumerStatefulWidget {
  const ListenProviderScreen({super.key});

  @override
  ConsumerState<ListenProviderScreen> createState() =>
      _ListenProviderScreenState();
}

class _ListenProviderScreenState extends ConsumerState<ListenProviderScreen>
    with TickerProviderStateMixin {
  late final TabController controller;
  //검색기록 저장용으로 쓰면 될거같음!
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(
        length: 10, vsync: this, initialIndex: ref.read(listenProvider));
  }

  @override
  Widget build(BuildContext context) {
    /// ref 가 글로벌하게 존재하게됨
    ref.listen<int>(listenProvider, (previous, next) {
      if (previous != next) {
        controller.animateTo(next);
      }
    });
    return DefaultLayout(
        title: "ListenProviderScreen",
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: List.generate(
            10,
            (index) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(index.toString()),
                ElevatedButton(
                  onPressed: () {
                    ref.read(listenProvider.notifier).update(
                          (state) => state == 10 ? 10 : state + 1,
                        );
                  },
                  child: Text('다음'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(listenProvider.notifier).update(
                          (state) => state == 0 ? 0 : state - 1,
                        );
                  },
                  child: Text('뒤로'),
                ),
              ],
            ),
          ),
        ));
  }
}
