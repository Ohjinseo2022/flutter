import 'package:flutter/material.dart';
import 'package:store_study/layout/default_layout.dart';
import 'package:store_study/screen/auto_dispose_modifier_screen.dart';
import 'package:store_study/screen/code_generation_screen.dart';
import 'package:store_study/screen/family_modifier_screen.dart';
import 'package:store_study/screen/future_provider_screen.dart';
import 'package:store_study/screen/listen_porvider_screen.dart';
import 'package:store_study/screen/provider_screen.dart';
import 'package:store_study/screen/select_provider_screen.dart';
import 'package:store_study/screen/state_notifier_provider_screen.dart';
import 'package:store_study/screen/state_provider_screen.dart';
import 'package:store_study/screen/stream_provider_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "HomeScreen",
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => StateProviderScreen()));
            },
            child: Text(
              'StateProviderScreen',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => StateNotifierProviderScreen()));
            },
            child: Text(
              'StateNotifierProviderScreen',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => FutureProviderScreen()));
            },
            child: Text(
              'FutureProviderScreen',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => StreamProviderScreen()));
            },
            child: Text(
              'StreamProviderScreen',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => FamilyModifierScreen()));
            },
            child: Text(
              'FamilyModifierScreen',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => AutoDisposeModifierScreen()));
            },
            child: Text(
              'AutoDisposeModifierScreen',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ListenProviderScreen()));
            },
            child: Text(
              'ListenProviderScreen',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => SelectProviderScreen()));
            },
            child: Text(
              'SelectProviderScreen',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ProviderScreen()));
            },
            child: Text(
              'ProviderScreen',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => CodeGenerationScreen()));
            },
            child: Text(
              'CodeGenerationScreen',
            ),
          )
        ],
      ),
    );
  }
}
