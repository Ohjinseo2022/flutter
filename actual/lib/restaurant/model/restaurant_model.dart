import 'package:actual/common/const/data.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap;
  //
  // String get parserRestaurantPriceRangeTypeToString {
  //   switch (this) {
  //     case RestaurantPriceRange.high:
  //       return 'high';
  //     case RestaurantPriceRange.medium:
  //       return 'medium';
  //     case RestaurantPriceRange.low:
  //       return 'low';
  //     default:
  //       return throw 'RestaurantPriceRange 타입이 아닙니다.';
  //   }
  // }
}

class RestaurantModel {
  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });
  //좀더 편하게 사용하기 위한 생성자 !!
  factory RestaurantModel.fromJson({required Map<String, dynamic> Json}) {
    return RestaurantModel(
      id: Json['id'],
      name: Json['name'],
      thumbUrl: 'http://$ip${Json['thumbUrl']}',
      tags: List<String>.from(Json['tags']),
      priceRange: RestaurantPriceRange.values
          .firstWhere(((e) => e.name == Json['priceRange'])),
      ratings: Json['ratings'],
      ratingsCount: Json['ratingsCount'],
      deliveryTime: Json['deliveryTime'],
      deliveryFee: Json['deliveryFee'],
    );
  }
}
