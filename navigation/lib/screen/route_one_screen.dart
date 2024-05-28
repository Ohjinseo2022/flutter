import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route_two_screen.dart';

class RouteOneScreen extends StatefulWidget {
  final int number;
  const RouteOneScreen({super.key, required this.number});

  @override
  State<RouteOneScreen> createState() => _RouteOneScreenState();
}

class _RouteOneScreenState extends State<RouteOneScreen> {
  dynamic data;
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "RouteOneScreen",
      children: [
        Text(
          'argument : ${widget.number}',
          textAlign: TextAlign.center,
        ),
        OutlinedButton(
          onPressed: () {
            data = {"number": 456};
            //pop도 다양한 기능이있음
            Navigator.of(context).pop(
              data,
            );
          },
          child: Text("Pop"),
        ),
        OutlinedButton(
          onPressed: () {
            data = {"number": 456};
            //pop도 다양한 기능이있음
            Navigator.of(context).maybePop(
              data,
            );
          },
          child: Text("Maybe Pop"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return RouteTwoScreen();
                },
                settings: RouteSettings(
                  arguments: 789,
                ),
              ),
            );
          },
          child: Text("push"),
        ),
      ],
    );
  }
}
