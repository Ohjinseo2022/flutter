import 'package:actual/common/const/data.dart';
import 'package:actual/common/dio/dio.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/product/component/product_card.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String id;
  final String title;
  RestaurantDetailScreen({super.key, required this.id, required this.title});
  //아예 초창기 로직
  Future<RestaurantDetailModel> detailRestaurant(WidgetRef ref) async {
    // final dio = Dio();
    // dio.interceptors.add(
    //   CustomInterceptor(storage: storage),
    // );
    // UI 관련 로직은 UI 관련된 것 만 있는게 베스트
    // final dio = ref.watch(dioProvider);
    // final repository =
    //     RestaurantRepository(dio, baseUrl: "http://$ip/restaurant");
    // return repository.getRestaurantDetail(id: id);
    //이걸 바로 future 에 넣어도 무방하다
    return ref.watch(restaurantRepositoryProvider).getRestaurantDetail(id: id);

    // final accessToken = await storage.read(key: ACCESS_TOKEN_KEY); //5분
    // final response = await dio.get(
    //   'http://$ip/restaurant/$id',
    //   options: Options(
    //     headers: {'authorization': 'Bearer $accessToken'},
    //   ),
    // );
    // return response.data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: title,
      child: FutureBuilder<RestaurantDetailModel>(
          future: ref
              .watch(restaurantRepositoryProvider)
              .getRestaurantDetail(id: id),
          builder: (context, AsyncSnapshot<RestaurantDetailModel> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            print(snapshot.data);
            // final pItem = RestaurantDetailModel.fromJson(snapshot.data!);
            return CustomScrollView(
              slivers: [
                renderTop(model: snapshot.data!),
                renderLabel(),
                renderProducts(products: snapshot.data!.products),
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

  SliverToBoxAdapter renderTop({required model}) {
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
