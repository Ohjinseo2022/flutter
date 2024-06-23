import 'package:dusty_dust/component/category_stat.dart';
import 'package:dusty_dust/component/hourly_stat.dart';
import 'package:dusty_dust/component/main_stat.dart';
import 'package:dusty_dust/const/color.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:dusty_dust/utils/status_utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Region region = Region.seoul;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    StatRepository.fetchData();
    getCount();
  }

  getCount() async {
    print(await GetIt.I<Isar>().statModels.count());
  }

  // StatRepository.fetchData(itemCode: ItemCode.PM10)
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatModel?>(
        future: GetIt.I<Isar>()
            .statModels
            .filter()
            .regionEqualTo(region)
            .itemCodeEqualTo(ItemCode.PM10)
            .sortByDateTimeDesc()
            .findFirst(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final statModel = snapshot.data!;
          final statusModel =
              StatusUtils.getStatusModelFromStat(stat: statModel);
          return Scaffold(
            drawer: Drawer(
              backgroundColor: statusModel.darkColor,
              child: ListView(children: [
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  child: Text(
                    '지역선택',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                ...Region.values
                    .map((e) => ListTile(
                          selected: e == region,
                          tileColor: Colors.white,
                          selectedTileColor: statusModel.lightColor,
                          selectedColor: Colors.black,
                          onTap: () {
                            setState(() {
                              region = e;
                            });
                            Navigator.of(context).pop();
                          },
                          title: Text(e.krName),
                        ))
                    .toList(),
              ]),
            ),
            appBar: AppBar(
              backgroundColor: statusModel.primaryColor,
              surfaceTintColor: statusModel.primaryColor,
            ),
            backgroundColor: statusModel.primaryColor,
            body: SingleChildScrollView(
              child:
                  // FutureBuilder<List<StatModel>>(
                  //     future: null,
                  //     builder: (context, snapshot) {
                  //       // 정확한 에러위치 파악 가능 !!!!!
                  //       // print(snapshot.stackTrace);
                  //       // print(snapshot.data);
                  //       if (snapshot.hasData) {
                  //         //스펠링 에러 무조건 발생 할듯! 모델을 만들어서 데이터를 규격화 진행후 개발을 진행할 필요성이 있다
                  //         //java 의 DTO ts의 interface 개념이라고 보면 될듯 ?
                  //         // print(snapshot.data!['response']['body']['items']);
                  //       }
                  //       return
                  Column(
                children: [
                  MainStat(
                    region: region,
                  ),
                  CategoryStat(
                    region: region,
                    darkColor: statusModel.darkColor,
                    lightColor: statusModel.lightColor,
                  ),
                  HourlyStat(
                    region: region,
                    darkColor: statusModel.darkColor,
                    lightColor: statusModel.lightColor,
                  ),
                ],
              ),
              // }),
            ),
          );
        });
  }
}
