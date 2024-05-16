import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: HomeScreen(),
    ),
  );
}

// StatelessWidget
// 여러개의 위젯을 하나로 묶는 역할 -> 웹에서의 컴포넌트화 개념인듯 !
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    //빌드 함수 내부에 내용이 변경되면 핫 리로드 , 즉 재시작 하지 않아도 시뮬레이터에 즉시 반영됨
    return Scaffold(
        //#8e1dad
        backgroundColor: const Color(0xff8e1dad),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32.0,
          ),
          child: Column(
            //여러개의 위젯을 사용하기 위함
            mainAxisAlignment: MainAxisAlignment.center, //정렬 기준
            children: [
              Image.asset(
                'asset/img/logo.png',
              ),
              const SizedBox(
                height: 28.0,
              ),
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ));
  }
}
