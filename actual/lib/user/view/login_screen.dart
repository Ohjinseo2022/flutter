import 'dart:convert';
import 'dart:io';

import 'package:actual/common/component/custom_text_form_field.dart';
import 'package:actual/common/const/colors.dart';
import 'package:actual/common/const/data.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/common/secure_storage/secure_storage.dart';
import 'package:actual/common/view/root_tab.dart';
import 'package:actual/user/model/user_model.dart';
import 'package:actual/user/provider/user_me_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';
  LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String userName = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    // final storage = FlutterSecureStorage();
    final state = ref.watch(userMeProvider);

    return DefaultLayout(
      //외부 스크롤시 키보드 사라지게해야함
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                SizedBox(
                  height: 16.0,
                ),
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요.',
                  onChanged: (String value) {
                    userName = value;
                  },
                  autofocus: true,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요.',
                  onChanged: (String value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                      foregroundColor: Colors.white),
                  onPressed: state is UserModelLoading
                      ? null
                      : () async {
                          ref
                              .read(userMeProvider.notifier)
                              .login(username: userName, password: password);
                          // ID:비밀번호
                          // String rawString = "$userName:$password";
                          // Codec<String, String> stringToBase64 = utf8.fuse(base64);
                          // String token = stringToBase64.encode(rawString);
                          // final response = await dio.post(
                          //   'http://$ip/auth/login',
                          //   options: Options(
                          //     headers: {
                          //       'authorization': 'Basic $token',
                          //     },
                          //   ),
                          // );
                          // final refreshToken = response.data['refreshToken'];
                          // final accessToken = response.data['accessToken'];
                          // final storage = ref.read(secureStorageProvider);
                          // // 1. 토큰이 유효한지 체크한다
                          // // 2. 토크인 유효하다면 로그인페이지는 패스
                          // await storage.write(
                          //     key: REFRESH_TOKEN_KEY, value: refreshToken);
                          // await storage.write(
                          //     key: ACCESS_TOKEN_KEY, value: accessToken);
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (_) => RootTab()));
                        },
                  child: Text("로그인"),
                ),
                TextButton(
                    onPressed: () async {},
                    style: TextButton.styleFrom(foregroundColor: PRIMARY_COLOR),
                    child: Text(
                      '회원가입',
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)",
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
