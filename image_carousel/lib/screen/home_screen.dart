import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //무언가를 생성했다면 화면에서 벗어날떄 컨트롤러를 삭제해줘야한다.
  Timer? timer;
  PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      int currentPage = controller.page!.toInt();
      int nextPage = currentPage + 1;
      if (nextPage > 4) {
        nextPage = 0;
      }
      controller.animateToPage(
        nextPage, duration: Duration(milliseconds: 500), // 이동하는 속도
        curve: Curves.easeInBack,
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (timer != null) {
      timer!.cancel();
    }
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [1, 2, 3, 4, 5]
            .map(
              (number) => Image.asset(
                'asset/img/image_$number.jpeg',
                fit: BoxFit.cover,
              ),
            )
            .toList(),
      ),
    );
  }
}
