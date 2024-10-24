import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/common/model/model_with_id.dart';
import 'package:actual/common/model/pagination_params.dart';
import 'package:actual/common/repository/base_pagination_repository.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _PaginationInfo {
  final int fetchCount;
  final bool fetchMore;
  final bool forceRefetch;
  _PaginationInfo(
      {this.fetchCount = 20,
      this.fetchMore = false,
      this.forceRefetch = false});
}

class PaginationProvider<T extends IModelWithId,
        U extends IBasePaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  final U repository;
  final paginationThrottle = Throttle(Duration(seconds: 3),
      initialValue: _PaginationInfo(),
      checkEquality: false // 함수실행할때 마다 스로틀링이 걸리게 한다
      );
  PaginationProvider({required this.repository})
      : super(CursorPaginationLoading()) {
    //RestaurantStateNotifier 이 생성되는 순간 paginate() 가 실행된다.
    paginate();
    //스로틀링 세팅
    paginationThrottle.values.listen((state) {
      _throttledPagination(state);
    });
  }

  Future<void> paginate({
    int fetchCount = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    // _throttledPagination();
    paginationThrottle.setValue(_PaginationInfo(
        fetchCount: fetchCount,
        fetchMore: fetchMore,
        forceRefetch: forceRefetch));
  }

  _throttledPagination(_PaginationInfo info) async {
    final fetchCount = info.fetchCount;
    final fetchMore = info.fetchMore;
    final forceRefetch = info.forceRefetch;
    try {
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;

        if (!pState.meta.hasMore) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );
      if (fetchMore) {
        final pState = state as CursorPagination<T>;

        state = CursorPaginationFetchingMore(
          data: pState.data,
          meta: pState.meta,
        );
        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
        // ㄷㅔ이터를 처음부터 가져오는 상황
      } else {
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination<T>;
          state = CursorPaginationRefetching<T>(
            data: pState.data,
            meta: pState.meta,
          );
        } else {
          state = CursorPaginationLoading();
        }
      }
      final response = await repository.paginate(
        paginationParams: paginationParams,
      );
      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<T>;
        state = response.copyWith(
          data: [...pState.data, ...response.data],
          // meta: response.meta,
        );
      } else {
        state = response;
      }
    } catch (e, stack) {
      print(e);
      print(stack);
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
