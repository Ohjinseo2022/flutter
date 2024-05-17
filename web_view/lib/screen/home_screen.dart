import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUrl = Uri.parse('https://www.naver.com/');

class HomeScreen extends StatelessWidget {
  //WebViewController controller = WebViewController();
  //controller.loadRequest(homeUrl);
  // .. 은 함수실행된 결과값이아닌 함수가 실행되는 대상을 리턴해준다!
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(homeUrl);

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 타이틀을 제공해줌
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text(
          '오진서 공부중',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        //앱바에 기능을 넣는 기능
        actions: [
          IconButton(
            onPressed: () {
              controller.loadRequest(homeUrl);
            },
            icon: Icon(
              Icons.home,
            ),
          )
        ],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
