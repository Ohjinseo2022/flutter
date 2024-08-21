import 'package:go_router/go_router.dart';
import 'package:go_router_v7/screens/1_basic_screen.dart';
import 'package:go_router_v7/screens/2_named_screen.dart';
import 'package:go_router_v7/screens/3_push_screen.dart';
import 'package:go_router_v7/screens/4_pop_base_screen.dart';
import 'package:go_router_v7/screens/5_pop_return_screen.dart';
import 'package:go_router_v7/screens/6_path_param_screen.dart';
import 'package:go_router_v7/screens/7_query_parameter_screen.dart';
import 'package:go_router_v7/screens/8_nested_child_screen.dart';
import 'package:go_router_v7/screens/8_nested_screen.dart';
import 'package:go_router_v7/screens/root_screen.dart';

// https://blog.codefactory.ai/ -> / -> path
// https://blog.codefactory.ai/flutter -> /flutter
// / -> home
// /basic -> basicScreen
// /basic/basic_two
// /named
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => RootScreen(),
      //route 안에 중첩 가능함!
      routes: [
        GoRoute(
          path: 'basic',
          builder: (context, state) => BasicScreen(),
        ),
        GoRoute(
          path: 'named',
          name: 'named_screen',
          builder: (context, state) => NamedScreen(),
        ),
        GoRoute(
          path: 'push',
          builder: (context, state) => PushScreen(),
        ),
        GoRoute(
          path: 'pop',
          builder: (context, state) => PopBaseScreen(),
          routes: [
            GoRoute(
              path: 'return',
              // /pop/return
              builder: (context, state) => PopReturnScreen(),
            )
          ],
        ),
        GoRoute(
          //파라미터를 받을 수 있음
          path: 'path_param/:id',
          // /path_param/123 ->> id 라는 변수로 입력 받을 수 있음
          builder: (context, state) => PathParamScreen(),
          routes: [
            GoRoute(
              path: ':name',
              //같은 위젯을 반환해도 독립된 위젝으로 인식함.!
              builder: (context, state) => PathParamScreen(),
            )
          ],
        ),
        GoRoute(
          path: 'query_param',
          builder: (context, state) => QueryParameterScreen(),
        ),
        //ShellRoute의 builder 는 내부 routes 의 전체를 감싸는 위젯을 만들수 있다.
        ShellRoute(
            builder: (context, state, child) {
              return NestedScreen(child: child);
            },
            routes: [
              GoRoute(
                path: 'nested/a',
                builder: (context, state) =>
                    NestedChildScreen(routeName: '/nested/a'),
              ),
              GoRoute(
                path: 'nested/b',
                builder: (context, state) =>
                    NestedChildScreen(routeName: '/nested/b'),
              ),
              GoRoute(
                path: 'nested/c',
                builder: (context, state) =>
                    NestedChildScreen(routeName: '/nested/c'),
              ),
            ])
      ],
    ),
  ],
);
