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
  final String? detail;
  RestaurantModel(
      {required this.id,
      required this.name,
      required this.thumbUrl,
      required this.tags,
      required this.priceRange,
      required this.ratings,
      required this.ratingsCount,
      required this.deliveryTime,
      required this.deliveryFee,
      this.detail});
  //좀더 편하게 사용하기 위한 생성자 !!
  factory RestaurantModel.fromJson({required Map<String, dynamic> json}) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: 'http://$ip${json['thumbUrl']}',
      tags: List<String>.from(json['tags']),
      priceRange: RestaurantPriceRange.values
          .firstWhere(((e) => e.name == json['priceRange'])),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
    );
  }
}
