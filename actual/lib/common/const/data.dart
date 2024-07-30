import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// final storage = FlutterSecureStorage();

//현재 실행 환경 파악
// 애플에서 시뮬레이터를 쓸떄는 - 시뮬레이터와 네트워크 환경이 똑같음
// 안드로이드의 경우 애뮬레이터와 컴퓨터와 네트워크가 다름
const emulatorIp = '10.0.2.2:3000'; //안드 localhost
const simulatorIp = '127.0.0.1:3000';

final String ip = Platform.isIOS ? simulatorIp : emulatorIp;
