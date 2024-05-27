import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';

class RouteOneScreen extends StatefulWidget {
  const RouteOneScreen({super.key});

  @override
  State<RouteOneScreen> createState() => _RouteOneScreenState();
}

class _RouteOneScreenState extends State<RouteOneScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(title: "RouteOneScreen", children: [
      OutlinedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("Pop"),
      )
    ]);
  }
}
