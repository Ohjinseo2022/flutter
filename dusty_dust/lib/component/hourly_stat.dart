import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class HourlyStat extends StatelessWidget {
  final Region region;
  final Color darkColor;
  final Color lightColor;
  const HourlyStat(
      {super.key,
      required this.region,
      required this.darkColor,
      required this.lightColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ItemCode.values
          .map((code) => FutureBuilder<List<StatModel>>(
                future: GetIt.I<Isar>()
                    .statModels
                    .filter()
                    .regionEqualTo(region)
                    .itemCodeEqualTo(code)
                    .sortByDateTimeDesc()
                    .limit(24)
                    .findAll(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final stats = snapshot.data!;
                  return SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        color: lightColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
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
                                  '시간별 ${code.krName}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            ...stats.map((stat) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 4.0,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${(stat.dateTime.hour.toString().padLeft(2, '0'))}시',
                                      ),
                                    ),
                                    Expanded(
                                      child: Image.asset(
                                        StatusUtils.getStatusModelFromStat(
                                                stat: stat)
                                            .imagePath,
                                        height: 20.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        stat.stat.toString(),
                                        textAlign: TextAlign.right,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                            // ...List.generate(
                            //   24,
                            //   (index) => Padding(
                            //     padding: EdgeInsets.symmetric(
                            //       horizontal: 16.0,
                            //       vertical: 4.0,
                            //     ),
                            //     child: Row(
                            //       children: [
                            //         Expanded(
                            //           child: Text(
                            //             '${(index + 1).toString().padLeft(2, '0')}시',
                            //           ),
                            //         ),
                            //         Expanded(
                            //           child: Image.asset(
                            //             'asset/img/best.png',
                            //             height: 20.0,
                            //           ),
                            //         ),
                            //         Expanded(
                            //           child: Text(
                            //             '보통',
                            //             textAlign: TextAlign.right,
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ))
          .toList(),
    );
  }
}
