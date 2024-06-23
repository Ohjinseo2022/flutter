import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class CategoryStat extends StatelessWidget {
  final Region region;
  final Color darkColor;
  final Color lightColor;
  CategoryStat(
      {super.key,
      required this.region,
      required this.darkColor,
      required this.lightColor});

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
                      //강의 듣기전 코드
                      child: ListView(
                        physics: PageScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: ItemCode.values
                            .map((code) => FutureBuilder<StatModel?>(
                                future: GetIt.I<Isar>()
                                    .statModels
                                    .filter()
                                    .regionEqualTo(region)
                                    .itemCodeEqualTo(code)
                                    .sortByDateTimeDesc()
                                    .findFirst(),
                                builder: (context, snapshot) {
                                  print("에러위치 파악${snapshot.stackTrace}");
                                  if (snapshot.hasError) {
                                    print('dd?');
                                    return Center(
                                      child: Text(snapshot.error.toString()),
                                    );
                                  }
                                  if (!snapshot.hasData &&
                                      snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  }

                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: Text('데이터가 없습니다.'),
                                    );
                                  }
                                  final statModel = snapshot.data!;
                                  return SizedBox(
                                    width: constraint.maxWidth / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(code.krName),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Image.asset(
                                          StatusUtils.getStatusModelFromStat(
                                                  stat: statModel)
                                              .imagePath,
                                          width: 50.0,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(statModel.stat.toString())
                                      ],
                                    ),
                                  );
                                }))
                            .toList(),
                      )
                      // FutureBuilder<List<StatModel>>(
                      //     future: getCategoryStat(),
                      //     builder: (context, snapshot) {
                      //       if (!snapshot.hasData &&
                      //           snapshot.connectionState ==
                      //               ConnectionState.waiting) {
                      //         return CircularProgressIndicator();
                      //       }
                      //
                      //       if (!snapshot.hasData) {
                      //         return Center(
                      //           child: Text('데이터가 없습니다.'),
                      //         );
                      //       }
                      //       return ListView(
                      //           physics: PageScrollPhysics(),
                      //           scrollDirection: Axis.horizontal,
                      //           children: snapshot.data!
                      //               .map(
                      //                 (statModel) => SizedBox(
                      //                   // width: MediaQuery.of(context).size.width / 3,
                      //                   width: constraint.maxWidth / 3,
                      //                   child: Column(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.center,
                      //                     children: [
                      //                       Text(
                      //                         statModel.itemCode.krName,
                      //                       ),
                      //                       SizedBox(
                      //                         height: 8.0,
                      //                       ),
                      //                       Image.asset(
                      //                         StatusUtils.getStatusModelFromStat(
                      //                                 stat: statModel)
                      //                             .imagePath,
                      //                         width: 50.0,
                      //                       ),
                      //                       SizedBox(
                      //                         height: 8.0,
                      //                       ),
                      //                       Text(statModel.stat.toString())
                      //                     ],
                      //                   ),
                      //                 ),
                      //               )
                      //               .toList());
                      //     }),
                      ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  //List<StatModel>
  Future<List<StatModel>> getCategoryStat() async {
    List<StatModel> result = [];
    for (ItemCode code in ItemCode.values) {
      final stat = await GetIt.I<Isar>()
          .statModels
          .filter()
          .regionEqualTo(region)
          .itemCodeEqualTo(code)
          .sortByDateTimeDesc()
          .findFirst();
      result = [...result, stat!];
    }

    return result;
  }
}
