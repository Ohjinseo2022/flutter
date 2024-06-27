import 'dart:convert';
import 'dart:io';

import 'package:actual/common/component/custom_text_form_field.dart';
import 'package:actual/common/const/colors.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    //현재 실행 환경 파악
    // 애플에서 시뮬레이터를 쓸떄는 - 시뮬레이터와 네트워크 환경이 똑같음
    // 안드로이드의 경우 애뮬레이터와 컴퓨터와 네트워크가 다름
    const emulatorIp = '10.0.2.2:3000'; //안드 localhost
    const simulatorIp = '127.0.0.1:3000';

    final String ip = Platform.isIOS ? simulatorIp : emulatorIp;

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
                const _Title(),
                const SizedBox(
                  height: 16.0,
                ),
                const _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요.',
                  onChanged: (String value) {},
                  autofocus: true,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요.',
                  onChanged: (String value) {},
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                      foregroundColor: Colors.white),
                  onPressed: () async {
                    // ID:비밀번호
                    const rawString = 'test@codefactory.ai:testtest';
                    Codec<String, String> stringToBase64 = utf8.fuse(base64);
                    String token = stringToBase64.encode(rawString);
                    final response = await dio.post(
                      'http://$ip/auth/login',
                      options: Options(
                        headers: {
                          'authorization': 'Basic $token',
                        },
                      ),
                    );
                    print(response.data);
                  },
                  child: Text("로그인"),
                ),
                TextButton(
                    onPressed: () async {
                      // ID:비밀번호
                      final String refreshToken =
                          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoicmVmcmVzaCIsImlhdCI6MTcxOTQ5NDY1NiwiZXhwIjoxNzE5NTgxMDU2fQ.QFhYmLh2Q6CM8UnzcWnuNEDqBs6qy0tqdKDkljw0BkM";
                      final response = await dio.post(
                        'http://$ip/auth/token',
                        options: Options(
                          headers: {
                            'authorization': 'Bearer $refreshToken',
                          },
                        ),
                      );
                      print(response.data);
                    },
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
        color: BODY_TEXXT_COLOR,
      ),
    );
  }
}
