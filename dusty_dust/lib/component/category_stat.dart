import 'package:dusty_dust/const/color.dart';
import 'package:flutter/material.dart';

class CategoryStat extends StatelessWidget {
  const CategoryStat({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        // 디자인 목적으로 많이 사용됨 배경과 쉐도우, 레디우스가 살짝 들어가있음 커스텀 컨테이너 느낌
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: LayoutBuilder(builder: (
            context,
            constraint,
          ) {
            return Column(
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
                      '종류별 통계',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        )),
                    child: ListView(
                      physics: PageScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        6,
                        (index) => SizedBox(
                          // width: MediaQuery.of(context).size.width / 3,
                          width: constraint.maxWidth / 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '미세먼지$index',
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Image.asset(
                                'asset/img/bad.png',
                                width: 50.0,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('${index * 1000}mg')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
