import 'package:actual/common/const/data.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY); //5분
    final response = await dio.get('http://$ip/restaurant',
        options: Options(headers: {'authorization': 'Bearer $accessToken'}));
    return response.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              print(snapshot.error);

              print(snapshot.data);
              print(snapshot.stackTrace);
              return ListView.separated(
                itemBuilder: (con, index) {
                  final item = snapshot.data![index];
                  final pItem = RestaurantModel.fromJson(Json: item);
                  //parsed
                  // final pItem = RestaurantModel(
                  //   id: item['id'],
                  //   name: item['name'],
                  //   thumbUrl: 'http://$ip${item['thumbUrl']}',
                  //   tags: List<String>.from(item['tags']),
                  //   priceRange: RestaurantPriceRange.values
                  //       .firstWhere(((e) => e.name == item['priceRange'])),
                  //   ratings: item['ratings'],
                  //   ratingsCount: item['ratingsCount'],
                  //   deliveryTime: item['deliveryTime'],
                  //   deliveryFee: item['deliveryFee'],
                  // );
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
                  //factory 주운내 편함 ㄹㅇ 한곳에서 변경하면 모든 로직이 변경될 수 있따.!
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                RestaurantDetailScreen(id: pItem.id),
                          ),
                        );
                      },
                      child: RestaurantCard.fromModel(model: pItem));
                },
                separatorBuilder: (_, index) {
                  return SizedBox(
                    height: 16,
                  );
                },
                itemCount: snapshot.data!.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
