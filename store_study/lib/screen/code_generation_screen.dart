import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_study/layout/default_layout.dart';
import 'package:store_study/riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state1 = ref.watch(gStateProvider);
    final state2 = ref.watch(gStateFutureProvider);
    final state3 = ref.watch(gStateFuture2Provider);
    final state4 = ref.watch(gStateMultiplyProvider(number1: 10, number2: 20));
    final state5 = ref.watch(gStateNotifierProvider);
    return DefaultLayout(
        title: "CodeGenerationScreen",
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('State1 : $state1'),
            state2.when(
              data: (data) {
                return Text(
                  "State2 : $data",
                  textAlign: TextAlign.center,
                );
              },
              error: (err, stack) {
                return Text(err.toString());
              },
              loading: () => Center(child: CircularProgressIndicator()),
            ),
            state3.when(
              data: (data) {
                return Text(
                  "State3 : $data",
                  textAlign: TextAlign.center,
                );
              },
              error: (err, stack) {
                return Text(err.toString());
              },
              loading: () => Center(child: CircularProgressIndicator()),
            ),
            Text('State4 : $state4'),
            Text('State5 : $state5'),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      ref.read(gStateNotifierProvider.notifier).increment();
                    },
                    child: Text('Increment')),
                ElevatedButton(
                    onPressed: () {
                      ref.read(gStateNotifierProvider.notifier).decrement();
                    },
                    child: Text('Decrement')),
              ],
            ),
            //invalidate()
            //유효하지 않게 하다.
            ElevatedButton(
                onPressed: () {
                  ref.invalidate(gStateNotifierProvider); // 초기화 개념인듯 ?
                },
                child: Text('Invalidate')),
          ],
        ));
  }
}
