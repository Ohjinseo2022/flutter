import 'package:actual/common/const/data.dart';
import 'package:actual/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

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

@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
//매핑을 커스텀하고 싶을때
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  // final String? detail;
//factory를 자동으로 만들어 줄수있는 친구가 있음

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
  }); //   this.detail
//
  //자동 생성됨
  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  //좀더 편하게 사용하기 위한 생성자 !!
  // factory RestaurantModel.fromJson({required Map<String, dynamic> json}) {
  //   return RestaurantModel(
  //     id: json['id'],
  //     name: json['name'],
  //     thumbUrl: 'http://$ip${json['thumbUrl']}',
  //     tags: List<String>.from(json['tags']),
  //     priceRange: RestaurantPriceRange.values
  //         .firstWhere(((e) => e.name == json['priceRange'])),
  //     ratings: json['ratings'],
  //     ratingsCount: json['ratingsCount'],
  //     deliveryTime: json['deliveryTime'],
  //     deliveryFee: json['deliveryFee'],
  //   );
  // }
}
