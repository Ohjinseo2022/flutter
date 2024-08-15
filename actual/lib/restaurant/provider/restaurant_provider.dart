//FutureBuilder에 의존해서 캐싱을 하는 것이 아닌  Provider 를 통해 전역으로 캐싱 관리
import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/common/model/pagination_params.dart';
import 'package:actual/common/provider/pagination_provider.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:collection/collection.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);
  if (state is! CursorPagination) {
    return null;
  }
  return state.data.firstWhereOrNull((element) => element.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestaurantStateNotifier(repository: repository);

  return notifier;
});

//제네릭 타입 <> 안에 집어넣으면 무조건 고정된상태가 넘어가야 한다.
// <CursorPaginationBase> 이 상태로 넣으면 이 친구를 상속 받은 친구는 다 들어갈 수 있다.
class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  //초기값 빈 리스트
  RestaurantStateNotifier({
    required super.repository,
  });
  // {
  //   //RestaurantStateNotifier 이 생성되는 순간 paginate() 가 실행된다.
  //   paginate();
  // }
  // Future<void> paginate({
  //   int fetchCount = 20,
  //   //추가로 데이터 더 가져오기
  //   // true - 추가로 데이터 더 가져옴
  //   // false - 새로고침 (현재 상태를 덮어 씌움)
  //   bool fetchMore = false,
  //   // 강제로 다시 로딩하기
  //   // true - CursorPaginationLoading()
  //   bool forceRefetch = false,
  // }) async {
  //   // final response = await repository.paginate();
  //   // state = response;
  //   try {
  //     // 5가지 가능성
  //     // State 의 상태
  //     // [상태]
  //     // 1) CursorPagination - 정상적으로 데이터가 있는 상태
  //     // 2) CursorPaginationLoading - 데이터가 로딩중인 상태(현재 캐시 없는 상태)
  //     // 3) CursorPaginationError - 에러가 있는 상태
  //     // 4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터를 가져올때
  //     // 5) CursorPaginationFetchMore - 추가 데이터를 paginate 해오라는 요청을 받았을때.
  //
  //     // 바로 반환하는 상황
  //     // 1) hasMore = false (기존 상태에서 이미 다음 데이터가 없다는 값을 들고있다면)
  //     // 2) 로딩중 - fetchMore : true
  //     //    fetchMore가 아닐때 - 새로고침의 의도가 있을 수 있다.
  //
  //     // 1)
  //     if (state is CursorPagination && !forceRefetch) {
  //       final pState = state as CursorPagination;
  //
  //       if (!pState.meta.hasMore) {
  //         return;
  //       }
  //     }
  //     // 완전 처음 로딩상태
  //     final isLoading = state is CursorPaginationLoading;
  //     // 데이터를 받아온적이 있지만 유저가 새로고침을 진행함
  //     final isRefetching = state is CursorPaginationRefetching;
  //     final isFetchingMore = state is CursorPaginationFetchingMore;
  //     //2)
  //     if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
  //       return;
  //     }
  //     // PaginationParams 생성
  //     PaginationParams paginationParams = PaginationParams(
  //       count: fetchCount,
  //     );
  //     // fetchMore
  //     // 데이터를 추가로 가져오는 상황
  //     if (fetchMore) {
  //       final pState = state as CursorPagination;
  //       state = CursorPaginationFetchingMore(
  //         data: pState.data,
  //         meta: pState.meta,
  //       );
  //       paginationParams = paginationParams.copyWith(
  //         after: pState.data.last.id,
  //       );
  //     } // 데이터를 처음부터 가져오는 상황
  //     else {
  //       // 만약에 데이터가 있는 상황이라면
  //       // 기존 데이터를 보존한채로 Fetch (API 요청)를 진행
  //       if (state is CursorPagination && !forceRefetch) {
  //         final pState = state as CursorPagination;
  //         // 새로 고침
  //         state =
  //             CursorPaginationRefetching(data: pState.data, meta: pState.meta);
  //       }
  //       // 나머지 상황
  //       else {
  //         state = CursorPaginationLoading();
  //       }
  //     }
  //
  //     final response = await repository.paginate(
  //       paginationParams: paginationParams,
  //     );
  //
  //     if (state is CursorPaginationFetchingMore) {
  //       final pState = state as CursorPaginationFetchingMore;
  //       // 기존 데이터에
  //       // 새로운 데이터 추가
  //       state = response.copyWith(
  //         data: [...pState.data, ...response.data], // 비구조화 할당
  //         meta: response.meta,
  //       );
  //     } else {
  //       state = response;
  //     }
  //   } catch (e) {
  //     state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
  //   }
  // }

  void getDetail({
    required String id,
  }) async {
    // 만약에 아직 데이터가 하나도 없는 상태라면 (CursorPagination 이 아니라면)
    // 데이터를 가져오는 시도를 한다.
    if (state is! CursorPagination) {
      await paginate();
    }
    // 그럼에도 state가 CursorPaginaiton 이 아닐때 그냥 리턴
    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;

    final response = await repository.getRestaurantDetail(id: id);

    // [RestaurantModel(1),RestaurantModel(2),RestaurantModel(3),]
    // 요청 id : 10
    // list.where((e)=>e.id == 10) 데이터 x
    // 데이터가 없을때는 그냥 캐시의 끝에다가 데이터를 추가해버린다.
    // [RestaurantModel(1),RestaurantModel(2),RestaurantModel(3),RestaurantModel(10)]
    if (pState.data.where((e) => e.id == id).isEmpty) {
      state =
          pState.copyWith(data: <RestaurantModel>[...pState.data, response]);
    } else {
      // [RestaurantModel(1),RestaurantModel(2),RestaurantModel(3),]
      // getDetail(id:2)
      // 통신 완료후 id 가 같은 데이터만 RestaurantDetailModel 로 변경됨
      // RestaurantDetailModel 도 RestaurantModel 을 상속받은 상태기 떄문에 문제가 생기지 않는다.
      // [RestaurantModel(1),RestaurantDetailModel(2),RestaurantModel(3),]
      state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>((e) => e.id == id ? response : e)
            .toList(),
      );
    }
  }
}
