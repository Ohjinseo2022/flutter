import 'package:actual/common/const/colors.dart';
import 'package:actual/product/model/product_model.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;
  ProductCard(
      {super.key,
      required this.image,
      required this.name,
      required this.detail,
      required this.price});

  factory ProductCard.fromProductModel({required ProductModel model}) {
    return ProductCard(
      image: Image.network(model.imgUrl,
          width: 110, height: 110, fit: BoxFit.cover),
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  factory ProductCard.fromRestaurantProductModel(
      {required RestaurantProductModel model}) {
    return ProductCard(
      image: Image.network(model.imgUrl,
          width: 110, height: 110, fit: BoxFit.cover),
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }
  // Image.asset(
  // 'asset/img/food/ddeok_bok_gi.jpg',
  // width: 110,
  // height: 110,
  // fit: BoxFit.cover,
  // ),
  @override
  Widget build(BuildContext context) {
    //IntrinsicHeight 하위 위젯들의  높이를 차지할 수 있는 높이의 최대 치로 조정IntrinsicWidth 이거도 있음 응용 가능할듯
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: image,
          ),
          //나머지 공간 전체차지
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  detail,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: BODY_TEXXT_COLOR,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  '$price',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
