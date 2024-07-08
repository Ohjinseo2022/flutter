import 'package:actual/common/const/data.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/product/component/product_card.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;
  final String title;
  RestaurantDetailScreen({super.key, required this.id, required this.title});

  Future<Map<String, dynamic>> detailRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY); //5분
    final response = await dio.get(
      'http://$ip/restaurant/$id',
      options: Options(
        headers: {'authorization': 'Bearer $accessToken'},
      ),
    );
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: title,
      child: FutureBuilder<Map<String, dynamic>>(
          future: detailRestaurant(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            print(snapshot.data);
            final pItem = RestaurantDetailModel.fromJson(snapshot.data!);
            return CustomScrollView(
              slivers: [
                rendarTop(model: pItem),
                renderLabel(),
                renderProducts(products: pItem.products),
              ],
            );

            //   Column(
            //   children: [
            //     RestaurantCard.fromModel(
            //       model: pItem,
            //       isDetail: true,
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //       child: ProductCard(),
            //     ),
            //   ],
            // );
          }),
    );
  }

  SliverToBoxAdapter rendarTop({required model}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  SliverPadding renderProducts(
      {required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromModel(model: products[index]),
            );
          },
          childCount: products.length,
        ),
      ),
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
