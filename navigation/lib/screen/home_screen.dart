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
    return PopScope(
      canPop:
          false, // 홈화면에서 나가는걸 막는 용도! 뒤로가기 버튼 연타시 해당 정보를 true 로 바꿔서 앱 종료하는 기능 구현 가능 할듯
      child: DefaultLayout(title: "HomeScreen", children: [
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
        ),
        OutlinedButton(
          onPressed: () {
            //pop도 다양한 기능이있음
            Navigator.of(context).pop(); // 마지막 스택일떄도 pop 처리를 ㅎ ㅐ서 화면자체가 사라질수 있음
          },
          child: Text("Pop"),
        ),
        OutlinedButton(
          onPressed: () {
            //pop도 다양한 기능이있음
            Navigator.of(context)
                .maybePop(); //-> route의 마지막 스택이 아닐때만 동작함 ! 좀더 안전한 페이지 이동처리 가능
          },
          child: Text("Maybe Pop"),
        ),
        OutlinedButton(
          onPressed: () {
            //pop도 다양한 기능이있음
            print(Navigator.of(context).canPop()); //-> pop이 가능한지 여부를 체크해준다.
          },
          child: Text("Can Pop"),
        ),
      ]),
    );
  }
}
