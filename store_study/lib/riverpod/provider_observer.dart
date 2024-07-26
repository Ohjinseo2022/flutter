import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    // Provider 들이 업데이트 됐을때 해당 함수가 실행됨
    print(
        '[Provider Updated] Provider : $provider / pv : $previousValue / nv : $newValue');
  }

  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value,
      ProviderContainer container) {
    // Provider 가 추가됐을때 동작한다
    print('[Provider Added] Provider : $provider / value : $value');
  }

  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider, ProviderContainer container) {
    //Provider 가 삭제 됐을떄
    print('[Provider Disposed] Provider : $provider');
  }
}
