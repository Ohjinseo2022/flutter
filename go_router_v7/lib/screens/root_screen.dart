import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7/layout/default_layout.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        body: ListView(
      children: [
        ElevatedButton(
          onPressed: () {
            context.go('/basic');
          },
          child: Text('Go_Basic'),
        ),
        ElevatedButton(
          onPressed: () {
            context.goNamed('named_screen');
          },
          child: Text('Go_Named'),
        ),
        ElevatedButton(
          onPressed: () {
            context.go('/push');
          },
          child: Text('Go_Push'),
        ),
        ElevatedButton(
          onPressed: () {
            context.go('/pop');
          },
          child: Text('Go_Pop'),
        ),
      ],
    ));
  }
}
