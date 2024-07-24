import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_study/layout/default_layout.dart';
import 'package:store_study/riverpod/select_provider.dart';

class SelectProviderScreen extends ConsumerWidget {
  const SelectProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("build");
    final state = ref.watch(selectProvider
        .select((value) => value.isSpicy)); //내가 필요한 정보가 바뀔때만 다시 랜더링
    // 필요한 부분이 변경될때만 리슨이 동작
    ref.listen(
      selectProvider.select((value) => value.hasBought),
      (previous, next) {
        print('next : $next');
      },
    );
    //최적화 단계에서 사용한다.
    //불필요한 랜더링과 불필요한 리슨을 최소화하는목적
    return DefaultLayout(
      title: "SelectProviderScreen",
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.toString()),
            // Text(state.name),
            // Text(state.isSpicy.toString()),
            // Text(state.hasBought.toString()),
            ElevatedButton(
                onPressed: () {
                  ref.read(selectProvider.notifier).toggleIsSpicy();
                },
                child: Text('Spicy Toggle')),
            ElevatedButton(
                onPressed: () {
                  ref.read(selectProvider.notifier).toggleHasBought();
                },
                child: Text('HasBought Toggle')),
          ],
        ),
      ),
    );
  }
}
