import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:store_study/layout/default_layout.dart';
import 'package:store_study/model/shopping_item_model.dart';
import 'package:store_study/riverpod/state_notifier_provider.dart';

class StateNotifierProviderScreen extends ConsumerWidget {
  const StateNotifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ShoppingItemModel> state = ref.watch(shoppingListProvider);
    return DefaultLayout(
      title: "StateNotifierProviderScreen",
      body: ListView(
        children: state
            .map((e) => CheckboxListTile(
                title: Text(e.name),
                value: e.hasBought,
                onChanged: (value) {
                  ref
                      .read(shoppingListProvider.notifier)
                      .toggleHasBought(name: e.name);
                }))
            .toList(),
      ),
    );
  }
}
