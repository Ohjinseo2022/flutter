import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7/screens/10_transition_screen_1.dart';
import 'package:go_router_v7/screens/10_transition_screen_2.dart';
import 'package:go_router_v7/screens/11_error_screen.dart';
import 'package:go_router_v7/screens/1_basic_screen.dart';
import 'package:go_router_v7/screens/2_named_screen.dart';
import 'package:go_router_v7/screens/3_push_screen.dart';
import 'package:go_router_v7/screens/4_pop_base_screen.dart';
import 'package:go_router_v7/screens/5_pop_return_screen.dart';
import 'package:go_router_v7/screens/6_path_param_screen.dart';
import 'package:go_router_v7/screens/7_query_parameter_screen.dart';
import 'package:go_router_v7/screens/8_nested_child_screen.dart';
import 'package:go_router_v7/screens/8_nested_screen.dart';
import 'package:go_router_v7/screens/9_login_screen.dart';
import 'package:go_router_v7/screens/9_private_screen.dart';
import 'package:go_router_v7/screens/root_screen.dart';

//로그인이 됐는지 안됐는지
//true - login OK / false - login no
bool authState = false;
// https://blog.codefactory.ai/ -> / -> path
// https://blog.codefactory.ai/flutter -> /flutter
// / -> home
// /basic -> basicScreen
// /basic/basic_two
// /named
final router = GoRouter(
  redirect: (context, state) {
    //return string -> 해당 라우트로 이동한다 (path)
    //return null -> 원래 이동하려던 라우트로 이동한다.
    if (state.location == '/login/private' && !authState) {
      return '/login';
    }
    return null;
  },
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
            ]),
        GoRoute(
          path: 'login',
          builder: (_, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'private',
              builder: (_, state) => PrivateScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'login2',
          builder: (_, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'private',
              builder: (_, state) => PrivateScreen(),
              //현재 라우트에 이동하려고 할때만 동작을함
              redirect: (context, state) {
                if (!authState) {
                  return '/login2';
                }
                return null;
              },
            ),
          ],
        ),
        GoRoute(
          path: 'transition',
          builder: (_, state) => TransitionScreenOne(),
          routes: [
            GoRoute(
                path: 'detail',
                // builder: (_, state) => TransitionScreenTwo(),
                pageBuilder: (_, state) => CustomTransitionPage(
                      transitionDuration: Duration(seconds: 3),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                        // return ScaleTransition(
                        //   scale: animation,
                        //   child: child,
                        // );
                        // return RotationTransition(
                        //   turns: animation,
                        //   child: child,
                        // );
                      },
                      child: TransitionScreenTwo(),
                    )),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => ErrorScreen(error: state.error.toString()),
  debugLogDiagnostics: true,
);
