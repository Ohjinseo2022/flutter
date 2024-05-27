import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route_one_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    dynamic result;
    return DefaultLayout(title: "HomeScreen", children: [
      OutlinedButton(
        onPressed: () async {
          Map<String, dynamic> result =
              await Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              return RouteOneScreen(
                number: 33,
              );
            },
          ));
          result.forEach((key, value) => print('라우트 결과 $key : $value'));
        },
        child: Text('push'),
      )
    ]);
  }
}
