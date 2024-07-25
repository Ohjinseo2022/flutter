import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_study/model/shopping_item_model.dart';
import 'package:store_study/riverpod/state_notifier_provider.dart';

final filteredShoppingListProvider = Provider<List<ShoppingItemModel>>(
  (ref) {
    final filterState = ref.watch(filterProvider);
    final shoppingListSate = ref.watch(shoppingListProvider);
    if (filterState == FilterState.all) {
      return shoppingListSate;
    }
    return shoppingListSate
        .where((element) => filterState == FilterState.spicy
            ? element.isSpicy
            : !element.isSpicy)
        .toList();
  },
);

enum FilterState {
// 안매움
  notSpicy,
//매움
  spicy,
//전부
  all,
}

final filterProvider = StateProvider<FilterState>((ref) => FilterState.all);
