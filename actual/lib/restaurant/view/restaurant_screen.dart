import 'package:actual/common/const/data.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
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
                  return RestaurantCard(
                    image: Image.network("http://$ip${item['thumbUrl']}",
                        fit: BoxFit.cover),
                    // image: Image.asset(
                    //   'asset/img/food/ddeok_bok_gi.jpg',
                    //   fit: BoxFit.cover,
                    // ),
                    name: item['name'],
                    tags: List<String>.from(item['tags']),
                    ratings: item['ratings'],
                    ratingsCount: item['ratingsCount'],
                    deliveryTime: item['deliveryTime'],
                    deliveryFee: item['deliveryFee'],
                  );
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
