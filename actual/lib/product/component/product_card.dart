import 'dart:ui';

import 'package:actual/common/const/colors.dart';
import 'package:actual/product/model/product_model.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:actual/user/provider/basket_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;
  final String id;
  final VoidCallback? onSubtract;
  final VoidCallback? onAdd;
  ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    required this.id,
    this.onSubtract,
    this.onAdd,
  });

  factory ProductCard.fromProductModel(
      {required ProductModel model,
      VoidCallback? onSubtract,
      VoidCallback? onAdd}) {
    return ProductCard(
      image: Image.network(model.imgUrl,
          width: 110, height: 110, fit: BoxFit.cover),
      name: model.name,
      detail: model.detail,
      price: model.price,
      id: model.id,
      onSubtract: onSubtract,
      onAdd: onAdd,
    );
  }

  factory ProductCard.fromRestaurantProductModel(
      {required RestaurantProductModel model,
      VoidCallback? onSubtract,
      VoidCallback? onAdd}) {
    return ProductCard(
      id: model.id,
      image: Image.network(model.imgUrl,
          width: 110, height: 110, fit: BoxFit.cover),
      name: model.name,
      detail: model.detail,
      price: model.price,
      onSubtract: onSubtract,
      onAdd: onAdd,
    );
  }
  // Image.asset(
  // 'asset/img/food/ddeok_bok_gi.jpg',
  // width: 110,
  // height: 110,
  // fit: BoxFit.cover,
  // ),
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);
    //IntrinsicHeight 하위 위젯들의  높이를 차지할 수 있는 높이의 최대 치로 조정IntrinsicWidth 이거도 있음 응용 가능할듯
    return Column(
      children: [
        IntrinsicHeight(
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
        ),
        if (onSubtract != null && onAdd != null)
          _Footer(
            total: (basket.firstWhere((e) => e.product.id == id).count *
                    basket.firstWhere((e) => e.product.id == id).product.price)
                .toString(),
            count: basket.firstWhere((e) => e.product.id == id).count,
            onSubtract: onSubtract!,
            onAdd: onAdd!,
          )
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final String total;
  final int count;
  final VoidCallback onSubtract;
  final VoidCallback onAdd;

  const _Footer(
      {super.key,
      required this.total,
      required this.count,
      required this.onSubtract,
      required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '총액 ₩$total',
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: [
            //
            renderButton(icon: Icons.remove, onTap: onSubtract),
            Text(
              count.toString(),
              style: TextStyle(
                color: PRIMARY_COLOR,
                fontWeight: FontWeight.w500,
              ),
            ),
            renderButton(icon: Icons.add, onTap: onAdd),
            //
          ],
        )
      ],
    );
  }

  Widget renderButton({required IconData icon, required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: PRIMARY_COLOR,
            width: 1.0,
          )),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}
