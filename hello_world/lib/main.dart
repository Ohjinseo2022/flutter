import 'package:flutter/material.dart';

void main() {
  //플러터 앱을 실행하는 내부 함수
  runApp(
    // 화면에 보여주고 싶은 요소를 집어넣는다
    // MaterialApp은 항상 최상위에 위치한다
    // Scaffold는 바로 아래 위치한다.
    // 위젯 -> Widget //화면에 보여지는 모든 요서는 위젯이다.
    const MaterialApp(
      debugShowCheckedModeBanner: false, // 개발 환경 체크 없애기
      home: Scaffold(
        // 여기까진 필수로 세팅 해놔야함!
        //배경색상을 정할수 있다
        backgroundColor:
            Colors.black, // enum 형태로 색상 설정 가능 => 직접 RGB 타입으로도 지정가능하다
        body: Center(
          child: Text(
            '안녕하세요 반갑습니다.',
            style: TextStyle(
              color:
                  Colors.white, // TextStyle 위젯 내부에 color 파라미터를 활용하여 텍스트 색상 변경가능
            ),
          ),
        ),
      ),
    ),
  );
}
