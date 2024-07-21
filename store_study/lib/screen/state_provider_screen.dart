import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_study/layout/default_layout.dart';
import 'package:store_study/riverpod/state_provider.dart';

//ConsumerWidget flutter_riverpod 에서 제공하는 위젯  StatelessWidget 과 99% 동일
class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //값 변화를 계속 인식하고 있음
    final provider = ref.watch(numberProvider);
    return DefaultLayout(
      title: "StateProviderScreen",
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            ElevatedButton(
                onPressed: () {
                  ref.read(numberProvider.notifier).update(
                        (state) => state + 1,
                      );
                },
                child: Text('UP')),
            ElevatedButton(
                onPressed: () {
                  ref.read(numberProvider.notifier).state =
                      ref.read(numberProvider.notifier).state - 1;
                },
                child: Text('DOWN')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => _NextScreen()));
                },
                child: Text('NextScreen')),
          ],
        ),
      ),
    );
  }
}

class _NextScreen extends ConsumerWidget {
  const _NextScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numberProvider);
    return DefaultLayout(
      title: "StateProviderScreen",
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            ElevatedButton(
                onPressed: () {
                  ref.read(numberProvider.notifier).update(
                        (state) => state + 1,
                      );
                },
                child: Text('UP'))
          ],
        ),
      ),
    );
  }
}
