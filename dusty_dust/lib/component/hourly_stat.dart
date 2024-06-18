import 'package:dusty_dust/const/color.dart';
import 'package:flutter/material.dart';

class HourlyStat extends StatelessWidget {
  const HourlyStat({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          color: lightColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: darkColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    '시간별 미세먼지',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              ...List.generate(
                24,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${(index + 1).toString().padLeft(2, '0')}시',
                        ),
                      ),
                      Expanded(
                        child: Image.asset(
                          'asset/img/best.png',
                          height: 20.0,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '보통',
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
