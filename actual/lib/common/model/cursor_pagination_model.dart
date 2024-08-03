import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

// CursorPaginationBase type 이 나오는지 안나오는지 가 중요함 현태 상태를 판단하기 위한 것
abstract class CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;
  CursorPaginationError({required this.message});
}

class CursorPaginationLoading extends CursorPaginationBase {}

// genericArgumentFactories: true, 을 사용하면 T 즉 다양한 모뎅을 외부에서 받아서 쓸수있게 고려한 코드가 자동으로 맵핑 됨 !
@JsonSerializable(
  genericArgumentFactories: true,
)
// CursorPaginationBase type 이 나오는지 안나오는지 가 중요함
class CursorPagination<T> extends CursorPaginationBase {
  final CursorPaginationMeta meta;
  //확정성을 위해 다른 방식으로 할거임
  // final List<RestaurantModel> data;
  //
  final List<T> data;
  CursorPagination({
    required this.meta,
    required this.data,
  });

  CursorPagination copyWith({
    CursorPaginationMeta? meta,
    List<T>? data,
  }) {
    return CursorPagination(meta: meta ?? this.meta, data: data ?? this.data);
  }

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
  CursorPaginationMeta copyWith({
    int? count,
    bool? hasMore,
  }) {
    return CursorPaginationMeta(
        count: count ?? this.count, hasMore: hasMore ?? this.hasMore);
  }

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}

// 새로고침 할때 CursorPagination 상속 받으며 CursorPaginationBase 도 상속 받음
class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({
    required super.data,
    required super.meta,
  });
}

// 리스트의 맨 아래로 내려서
// 추가 데이터를 요청하는중
class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({
    required super.data,
    required super.meta,
  });
}
