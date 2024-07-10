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
//   @GET('/')
//   paginate();
// http://$ip/reatauant/:id
  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
