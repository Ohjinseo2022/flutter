import 'package:actual/product/model/product_model.dart';
import 'package:actual/user/model/basket_item_model.dart';
import 'package:actual/user/model/patch_basket_body.dart';
import 'package:actual/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final basketProvider =
    StateNotifierProvider<BasketProvider, List<BasketItemModel>>((ref) {
  final repository = ref.watch(userMeRepositoryProvider);
  return BasketProvider(repository: repository);
});

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  final UserMeRepository repository;
  BasketProvider({required this.repository}) : super([]);

  Future<void> patchBasket() async {
    await repository.patchBasket(
        body: PatchBasketBody(
            basket: state
                .map((e) => PatchBasketBodyBasket(
                    productId: e.product.id, count: e.count))
                .toList()));
  }

  Future<void> addToBasket({
    required ProductModel product,
  }) async {
    // 요정을 먼저 보내고
    // 응답이 오면
    // 캐시를 업데이트 했다.
    //
    // 1) 아직 장바구니에 해당되는 상품이 없다면
    //    장바구니에 상품을 추가한다.
    // 2) 만약에 이미 들어있다면
    //    장바구니에 있는 값에 +1을 한다.
    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (exists) {
      state = state
          .map((e) =>
              e.product.id == product.id ? e.copyWith(count: e.count + 1) : e)
          .toList();
    } else {
      state = [
        ...state,
        BasketItemModel(product: product, count: 1),
      ];
    }

    //Optimistic Response ( 긍정적 응답 )
    // 데이터 통신이 성공할거라고 가정한 후 데이터 통신을 진행. 좀더 좋은 사용자 경험을 얻을수 있음
    // 실패할 가능성이 매우매우 적고 실패해도 극정인 영향이 없을 경우 사용
    await patchBasket();
  }

  Future<void> removeFromBasket({
    required ProductModel product,
    // true 면 count 와 관계없이 삭제한다.
    bool isDelete = false,
  }) async {
    // 1) 장바구니에 상품이 존재할떄는
    //    1. 상품의 카운트가 1 보다 크면 -1 한다.
    //    2. 상품의 카운트가 1 이면 삭제한다.
    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;
    // 2) 상품이 존재하지 않을떄
    //    즉시 함수를 반환하고 아무것도 하지 않는다.
    if (!exists) {
      return;
    }
    final existingProduct = state.firstWhere((e) => e.product.id == product.id);
    if (existingProduct.count == 1 || isDelete) {
      state = state.where((e) => e.product.id != product.id).toList();
    } else {
      state = state
          .map((e) =>
              e.product.id == product.id ? e.copyWith(count: e.count - 1) : e)
          .toList();
    }
    await patchBasket();
  }
}
