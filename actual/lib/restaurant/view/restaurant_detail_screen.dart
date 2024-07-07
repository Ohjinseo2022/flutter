import 'package:actual/common/const/data.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/product/component/product_card.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;
  RestaurantDetailScreen({super.key, required this.id});

  Future<Map<String, dynamic>> detailRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY); //5분
    final response = await dio.get('http://$ip/restaurant/$id',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}));
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떡볶이',
      child: FutureBuilder<Map<String, dynamic>>(
          future: detailRestaurant(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            print(snapshot.data);
            final pItem = RestaurantModel.fromJson(Json: snapshot.data!);
            return Column(
              children: [
                RestaurantCard.fromModel(
                  model: pItem,
                  isDetail: true,
                ),
                ProductCard(),
              ],
            );
          }),
    );
  }
}
// return RestaurantCard(
//   image: Image.network(pItem.thumbUrl, fit: BoxFit.cover),
//   // image: Image.asset(
//   //   'asset/img/food/ddeok_bok_gi.jpg',
//   //   fit: BoxFit.cover,
//   // ),
//   name: pItem.name,
//   tags: pItem.tags,
//   ratings: pItem.ratings,
//   ratingsCount: pItem.ratingsCount,
//   deliveryTime: pItem.deliveryTime,
//   deliveryFee: pItem.deliveryFee,
// );
