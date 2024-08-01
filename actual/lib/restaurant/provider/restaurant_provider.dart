//FutureBuilder에 의존해서 캐싱을 하는 것이 아닌  Provider 를 통해 전역으로 캐싱 관리
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, List<RestaurantModel>>(
        (ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestaurantStateNotifier(repository: repository);

  return notifier;
});

class RestaurantStateNotifier extends StateNotifier<List<RestaurantModel>> {
  final RestaurantRepository repository;
  //초기값 빈 리스트
  RestaurantStateNotifier({
    required this.repository,
  }) : super([]) {
    //RestaurantStateNotifier 이 생성되는 순간 paginate() 가 실행된다.
    paginate();
  }
  paginate() async {
    final response = await repository.paginate();
    state = response.data;
  }
}
