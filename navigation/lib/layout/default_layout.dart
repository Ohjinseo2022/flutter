import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final List<Widget> children;
  final String title;
  const DefaultLayout({super.key, required this.children, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar 를 사용하면 route 스택이 쌓여 있는 상태라면 뒤로가기 버튼이 자동생성
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
