import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  // http://$ip/reatauant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository; //body 생성
// http://$ip/reatauant
  @GET('/')
  paginate();
// http://$ip/reatauant/:id
  @GET('/{id}')
  @Headers({
    'authorization':
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNzIwNTI3OTM0LCJleHAiOjE3MjA1MjgyMzR9.1Nd7AJOo72v2jUmvtFihCRi6FdlFjidcl2rlnGmTQFE"
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
