import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // settings.arguments 에 값을 전달 받으면 해당 값으로 아니면 null 이 들어옴
    final arguments = ModalRoute.of(context)?.settings.arguments;
    return DefaultLayout(
      title: "RouteTwoScreen",
      children: [
        Text(
          arguments.toString(),
          textAlign: TextAlign.center,
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Pop'),
        ),
        OutlinedButton(
          onPressed: () {
            //Declaractive 미리 라우터를 정의해놓고 이동할떄
            Navigator.of(context).pushNamed('/three', arguments: 111111);
          },
          child: const Text(
            'Push RouteThree',
            textAlign: TextAlign.center,
          ),
        ),
        OutlinedButton(
          onPressed: () {
            // 라우트 스택에서 기존 라우트를 덢어 씌워버림
            // ex [HomeScreen, RouteOneScreen, RouteTwoScreen]
            // push --> [HomeScreen, RouteOneScreen, RouteTwoScreen, RouteThreeScreen]
            // pushReplacement --> [HomeScreen, RouteOneScreen, RouteThreeScreen]
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) {
                    return RouteThreeScreen();
                  },
                  settings: RouteSettings(arguments: 986)),
            );
          },
          child: Text('Push Replacement'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed('/three', arguments: 987);
          },
          child: Text('Push Replacement'),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/three', (route) {
              //만약에 삭제할거면 (Route Stack) false 반환
              // 삭제를 하지 않을거면 true 반환
              //현재 라우트의 이름을 볼수있음
              return route.settings.name == '/';
            }, arguments: 987);
          },
          child: Text('Push Named And Remove Until'),
        ),
      ],
    );
  }
}
