import 'package:actual/common/const/colors.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/common/view/root_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderDoneScreen extends StatelessWidget {
  static String get routeName => 'order_done';
  const OrderDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.thumb_up_alt_outlined, color: PRIMARY_COLOR, size: 50.0),
            SizedBox(
              height: 32.0,
            ),
            Text(
              '결제가 완료 되었습니다.',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 32.0,
            ),
            ElevatedButton(
                onPressed: () {
                  context.goNamed(RootTab.routeName);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                    foregroundColor: Colors.white),
                child: Text(
                  '홈으로',
                ))
          ],
        ),
      ),
    );
  }
}
