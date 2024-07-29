import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_study/layout/default_layout.dart';
import 'package:store_study/riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');
    final state1 = ref.watch(gStateProvider);
    final state2 = ref.watch(gStateFutureProvider);
    final state3 = ref.watch(gStateFuture2Provider);
    final state4 = ref.watch(gStateMultiplyProvider(number1: 10, number2: 20));

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
            // 필요한 영역만 재빌드 처리 해주기 위함 !
            Consumer(
              builder: (context, ref, child) {
                print('builder build');
                final state5 = ref.watch(gStateNotifierProvider);
                return Row(
                  children: [Text('State5 : $state5'), child!],
                );
              },
              //builder 에 child 파라미터 추출가능
              //재랜더링 할때 퍼포먼스(자원)가 많이드는 위엣은 별도로 빼서 state과 연관된 친구만 재랜더링 가능
              child: Text('hello'),
            ),
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

class _StateFiveWidget extends ConsumerWidget {
  const _StateFiveWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state5 = ref.watch(gStateNotifierProvider);
    return Text('State5 : $state5');
  }
}
