import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_study/layout/default_layout.dart';
import 'package:store_study/riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state1 = ref.watch(gStateProvider);
    return DefaultLayout(
        title: "CodeGenerationScreen",
        body: Column(
          children: [Text('State1 : $state1')],
        ));
  }
}
