import 'package:dusty_dust/component/category_stat.dart';
import 'package:dusty_dust/component/hourly_stat.dart';
import 'package:dusty_dust/component/main_stat.dart';
import 'package:dusty_dust/const/color.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: StatRepository.fetchData(),
            builder: (context, snapshot) {
              print(snapshot.error);
              print(snapshot.data);
              if (snapshot.hasData) {
                //스펠링 에러 무조건 발생 할듯! 모델을 만들어서 데이터를 규격화 진행후 개발을 진행할 필요성이 있다
                //java 의 DTO ts의 interface 개념이라고 보면 될듯 ?
                print(snapshot.data!['response']['body']['items']);
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
