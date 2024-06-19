import 'package:dusty_dust/component/category_stat.dart';
import 'package:dusty_dust/component/hourly_stat.dart';
import 'package:dusty_dust/component/main_stat.dart';
import 'package:dusty_dust/const/color.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: FutureBuilder<List<StatModel>>(
            future: null,
            builder: (context, snapshot) {
              // 정확한 에러위치 파악 가능 !!!!!
              print(snapshot.stackTrace);
              print(snapshot.data);
              if (snapshot.hasData) {
                //스펠링 에러 무조건 발생 할듯! 모델을 만들어서 데이터를 규격화 진행후 개발을 진행할 필요성이 있다
                //java 의 DTO ts의 interface 개념이라고 보면 될듯 ?
                // print(snapshot.data!['response']['body']['items']);
              }
              return Column(
                children: [
                  MainStat(),
                  CategoryStat(),
                  HourlyStat(),
                ],
              );
            }),
      ),
    );
  }
}
