import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_study/layout/default_layout.dart';
import 'package:store_study/riverpod/state_provider_screen.dart';

//ConsumerWidget flutter_riverpod 에서 제공하는 위젯  StatelessWidget 과 99% 동일
class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({super.key});

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
                child: Text('up')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => _NextScreen()));
                },
                child: Text('_NextScreen')),
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
                child: Text('up'))
          ],
        ),
      ),
    );
  }
}
