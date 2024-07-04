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
}
