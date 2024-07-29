import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

// 1) 어떤 Provider를 사용할지 결정 및 고민할 필요 없도록
//Provider, FutureProvider, StreamProvider 등 자동 으로 만들어 준다.
//StateNotifierProvider 는 명시적으로 추가가능 하다.

final _testProvider = Provider<String>((ref) => "Hello Code Generation");

//제너레이션 만드는 규칙
@riverpod
String gState(GStateRef ref) => "Hello Code Generation";

//원래 Future 프로바이더는 캐싱이 돼야하지만, 코드 제너레이터를 사용하연 auto Dispose가 기본으로 동작한다
@riverpod
Future<int> gStateFuture(GStateFutureRef ref) async {
  await Future.delayed(Duration(seconds: 3));

  return 10;
}

//autoDispose 설정을 끄는방법
@Riverpod(keepAlive: true // Default false
    )
Future<int> gStateFuture2(GStateFuture2Ref ref) async {
  await Future.delayed(Duration(seconds: 3));

  return 10;
}

// 2) Parameter > Family 파라미터를 일반 함수처럼 사용할 수 있도록
class Parameter {
  final int number1;
  final int number2;

  Parameter({required this.number1, required this.number2});
}

final _testFamilyProvider = Provider.family<int, Parameter>(
    (ref, parameter) => parameter.number1 * parameter.number2);

@riverpod
int gStateMultiply(GStateMultiplyRef ref,
    {required int number1, required int number2}) {
  return number1 * number2;
}

@riverpod
class GStateNotifier extends _$GStateNotifier {
  @override
  int build() {
    return 0;
  }

  increment() {
    state++;
  }

  decrement() {
    state--;
  }
}
