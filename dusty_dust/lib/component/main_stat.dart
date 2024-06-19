import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/utils/date_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

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
        child: FutureBuilder<StatModel?>(
            future: GetIt.I<Isar>()
                .statModels
                .filter()
                .regionEqualTo(Region.seoul)
                .itemCodeEqualTo(ItemCode.PM10)
                .findFirst(),
            builder: (context, snapshot) {
              if (!snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (!snapshot.hasData) {
                return Center(
                  child: Text('데이터가 없습니다.'),
                );
              }

              final statModel = snapshot.data!;
              return Column(
                children: [
                  Text(
                    '서울',
                    style: defaultStyle.copyWith(
                      fontSize: 40,
                    ),
                  ),
                  Text(DateUtils.dateTimeToString(dateTime: statModel.dateTime),
                      style:
                          defaultStyle.copyWith(fontWeight: FontWeight.w500)),
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
              );
            }),
      ),
    );
  }
}
