import 'package:dusty_dust/const/status_level.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/utils/date_utils.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class MainStat extends StatelessWidget {
  final Region region;
  MainStat({super.key, required this.region});

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
                .regionEqualTo(region)
                .itemCodeEqualTo(ItemCode.PM10)
                .sortByDateTimeDesc()
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
              final status =
                  StatusUtils.getStatusModelFromStat(stat: statModel);
              return Column(
                children: [
                  Text(
                    region.krName,
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
                    status.imagePath,
                    //MediaQuery.of(context).size.width 기종별 사이즈를 구할수있다!
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(status.label,
                      style: defaultStyle.copyWith(
                        fontSize: 40,
                      )),
                  Text(
                    status.comment,
                    style: defaultStyle,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
