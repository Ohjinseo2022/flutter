import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //future 의 리턴 타입 지정
      body: StreamBuilder<int>(
        stream: streamNumbers(),
        // FutureBuilder<int>(
        //   future: getNumber(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //future 에서 반환해준 데이터를 받을수 있다.
          // snapshot.data;
          print('-------data---------');
          print('-------future의 상태가 바뀔때마다 재실행 됩니다.---------');
          print(snapshot.connectionState);
          print(snapshot.data);
          // ConnectionState.none; ->Future 또는 Stream이 입력되지 않은 상태.
          // ConnectionState.active; ->Stream에서만 존재 / 스트림 아직 실행중
          // ConnectionState.done; -> Future 또는 Stream이 종료 됐을떄
          // ConnectionState.waiting; -> 실행중
          //상태에 따른 분기 처리 가능
          if (snapshot.connectionState == ConnectionState.active) {
            // 상태에 따라 다른 화면을 보여줄 수 있음
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text(snapshot.data.toString()),
                ],
              ),
            );
          }
          //error 확인
          if (snapshot.hasError) {
            final error = snapshot.error;
            return Center(
              child: Text("에러 : $error"),
            );
          }
          //데이터가 존재하는지 확인
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Center(
              child: Text(
                data.toString(),
              ),
            );
          }
          return Center(
            child: Text(
              '데이터가 없습니다.',
            ),
          );
        },
      ),
    );
  }

  Future<int> getNumber() async {
    await Future.delayed((Duration(seconds: 3)));

    final random = Random();
    final result = random.nextInt(100);
    if (result > 50) throw "숫자가 너무 커용";
    return result;
  }

  Stream<int> streamNumbers() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      // if (i == 5) throw "던져 던져!";
      yield i;
    }
  }
}
