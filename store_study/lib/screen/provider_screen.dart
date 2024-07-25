import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_study/layout/default_layout.dart';
import 'package:store_study/riverpod/provider.dart';
import 'package:store_study/riverpod/state_notifier_provider.dart';

class ProviderScreen extends ConsumerWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //provider 안에 provider 를 사용할 수 있다 .
    final state = ref.watch(filteredShoppingListProvider);
    return DefaultLayout(
      title: "ProviderScreen",
      actions: [
        PopupMenuButton<FilterState>(
          itemBuilder: (_) => FilterState.values
              .map(
                (e) => PopupMenuItem(
                  value: e,
                  child: Text(
                    e.name,
                  ),
                ),
              )
              .toList(),
          onSelected: (value) {
            ref.read(filterProvider.notifier).update((state) => value);
          },
        )
      ],
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
