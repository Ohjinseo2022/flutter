import 'package:actual/common/component/pagination_list_view.dart';
import 'package:actual/common/const/data.dart';
import 'package:actual/common/dio/dio.dart';
import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/common/utils/pagination_utils.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/provider/restaurant_provider.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  // Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
  @override
  Widget build(BuildContext context) {
    return PaginationListView(
        provider: restaurantProvider,
        itemBuilder: <RestaurantModel>(_, index, model) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        RestaurantDetailScreen(id: model.id, title: model.name),
                  ),
                );
              },
              child: RestaurantCard.fromModel(model: model));
        });
  }
}

//
//     //최초 1회만 데이터 텅신이 이루어지게 만든것 그후엔 속도가 빠르다
//     final data = ref.watch(restaurantProvider);
//     // 진짜 초기 로딩 상태,.
//     if (data is CursorPaginationLoading) {
//       //data.length == 0 확인할 필요가 없음!
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//     //에러
//     if (data is CursorPaginationError) {
//       return Center(
//         child: Text(data.message),
//       );
//     }
//     //CursorPagination
//     //CursorPaginationFetchingMore
//     //CursorPaginationRefetching
//     final cp = data as CursorPagination;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: ListView.separated(
//         controller: controller,
//         itemCount: cp.data.length + 1,
//         itemBuilder: (con, index) {
//           if (index == cp.data.length) {
//             return Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               child: Center(
//                 child: data is CursorPaginationFetchingMore
//                     ? CircularProgressIndicator()
//                     : Text('마지막 데이터 입니다 ㅜㅜ'),
//               ),
//             );
//           }
//           final pItem = cp.data[index];
//           return GestureDetector(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (_) =>
//                         RestaurantDetailScreen(id: pItem.id, title: pItem.name),
//                   ),
//                 );
//               },
//               child: RestaurantCard.fromModel(model: pItem));
//         },
//         separatorBuilder: (_, index) {
//           return const SizedBox(
//             height: 16,
//           );
//         },
//       ),
//       // 이거도 과거 로직임 ! 프로 바이더 개편함...!
//       // FutureBuilder<CursorPagination<RestaurantModel>>(
//       //   future: ref.watch(restaurantRepositoryProvider).paginate(),
//       //   builder: (context,
//       //       AsyncSnapshot<CursorPagination<RestaurantModel>> snapshot) {
//       //     if (!snapshot.hasData) {
//       //       return const Center(child: CircularProgressIndicator());
//       //     }
//       //     if (snapshot.connectionState == ConnectionState.waiting) {
//       //       return const Center(child: CircularProgressIndicator());
//       //     }
//       //     print(snapshot.error);
//       //
//       //     print(snapshot.data);
//       //     print(snapshot.stackTrace);
//       //     return ListView.separated(
//       //       itemBuilder: (con, index) {
//       //         final pItem = snapshot.data!.data[index];
//       //         // final pItem = RestaurantModel.fromJson(item);
//       //         //parsed
//       //         // final pItem = RestaurantModel(
//       //         //   id: item['id'],
//       //         //   name: item['name'],
//       //         //   thumbUrl: 'http://$ip${item['thumbUrl']}',
//       //         //   tags: List<String>.from(item['tags']),
//       //         //   priceRange: RestaurantPriceRange.values
//       //         //       .firstWhere(((e) => e.name == item['priceRange'])),
//       //         //   ratings: item['ratings'],
//       //         //   ratingsCount: item['ratingsCount'],
//       //         //   deliveryTime: item['deliveryTime'],
//       //         //   deliveryFee: item['deliveryFee'],
//       //         // );
//       //         // return RestaurantCard(
//       //         //   image: Image.network(pItem.thumbUrl, fit: BoxFit.cover),
//       //         //   // image: Image.asset(
//       //         //   //   'asset/img/food/ddeok_bok_gi.jpg',
//       //         //   //   fit: BoxFit.cover,
//       //         //   // ),
//       //         //   name: pItem.name,
//       //         //   tags: pItem.tags,
//       //         //   ratings: pItem.ratings,
//       //         //   ratingsCount: pItem.ratingsCount,
//       //         //   deliveryTime: pItem.deliveryTime,
//       //         //   deliveryFee: pItem.deliveryFee,
//       //         // );
//       //         //factory 주운내 편함 ㄹㅇ 한곳에서 변경하면 모든 로직이 변경될 수 있따.!
//       //         return GestureDetector(
//       //             onTap: () {
//       //               Navigator.of(context).push(
//       //                 MaterialPageRoute(
//       //                   builder: (_) => RestaurantDetailScreen(
//       //                       id: pItem.id, title: pItem.name),
//       //                 ),
//       //               );
//       //             },
//       //             child: RestaurantCard.fromModel(model: pItem));
//       //       },
//       //       separatorBuilder: (_, index) {
//       //         return const SizedBox(
//       //           height: 16,
//       //         );
//       //       },
//       //       itemCount: snapshot.data!.data.length,
//       //     );
//       //   },
//       // ),
//     );
//   }
// }
