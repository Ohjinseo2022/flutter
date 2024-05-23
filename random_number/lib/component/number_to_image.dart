import 'package:flutter/material.dart';

class NumberToImage extends StatelessWidget {
  final int number;
  const NumberToImage({required this.number, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: number
            .toString()
            .split("")
            .map((item) => Image.asset(
                  "asset/img/$item.png",
                  width: 50,
                  height: 70,
                ))
            .toList());
  }
}
