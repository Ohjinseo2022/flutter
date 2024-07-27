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

// 2) Parameter > Family 파라미터를 일반 함수처럼 사용할 수 있도록
