import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

// genericArgumentFactories: true, 을 사용하면 T 즉 다양한 모뎅을 외부에서 받아서 쓸수있게 고려한 코드가 자동으로 맵핑 됨 !
@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPagination<T> {
  final CursorPaginationMeta meta;
  //확정성을 위해 다른 방식으로 할거임
  // final List<RestaurantModel> data;
  //
  final List<T> data;
  CursorPagination({
    required this.meta,
    required this.data,
  });
  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;
  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}
