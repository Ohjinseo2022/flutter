import 'package:flutter/material.dart';

class MainStat extends StatelessWidget {
  const MainStat({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 20.0,
    );
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              '서울',
              style: defaultStyle.copyWith(
                fontSize: 40,
              ),
            ),
            Text('2024-06-17 11:00',
                style: defaultStyle.copyWith(fontWeight: FontWeight.w500)),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'asset/img/good.png',
              //MediaQuery.of(context).size.width 기종별 사이즈를 구할수있다!
              width: MediaQuery.of(context).size.width / 2,
            ),
            SizedBox(
              height: 20,
            ),
            Text('보통',
                style: defaultStyle.copyWith(
                  fontSize: 40,
                )),
            Text(
              '나쁘지 않네요!',
              style: defaultStyle,
            ),
          ],
        ),
      ),
    );
  }
}
