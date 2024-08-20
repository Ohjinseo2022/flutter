import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7/layout/default_layout.dart';

class QueryParameterScreen extends StatelessWidget {
  const QueryParameterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        body: ListView(
      children: [
        Text('Query Parameter : ${GoRouterState.of(context).queryParameters}'),
        // /query_param?utm=google&source=1234
        // /query_param?name=ojs&age=33
        ElevatedButton(
          onPressed: () {
            context.push(
              // 해당 방식을 사용하면 웹에서 컨트롤하는 방식그대로 사용가능함 !
              Uri(
                path: '/query_param',
                queryParameters: {'name': 'ojs', 'age': '33'},
              ).toString(),
            );
          },
          child: Text('Query Parameter'),
        )
      ],
    ));
  }
}
