import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreem extends StatefulWidget {
  const HomeScreem({super.key});

  @override
  State<HomeScreem> createState() => _HomeScreemState();
}

class _HomeScreemState extends State<HomeScreem> {
  //lat 위도  lng 경도 순서
  final CameraPosition initialPosition = CameraPosition(
    target: LatLng(
      37.5214,
      126.9246,
    ),
    zoom: 15,
  );
  // FutureBuilder 을 사용하게 되면 initState() 사용 안해도 무방하다.!
  // @override
  // initState() {
  //   super.initState();
  //   checkPermission();
  // }

  // 위치권한을 가지는 함수
  checkPermission() async {
    //위치 권한 확인 변수
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    //위치 서비스가 활성화 된게 아닐때
    if (!isLocationEnabled) {
      throw Exception('위치 기능을 활성화해주세요.');
    }
    //위치 권한을 받는 친구
    LocationPermission checkedPermission = await Geolocator.checkPermission();

    /* LocationPermission
    * values
    * whileInUse 앱 사용중 일때만
    * always 항상 - 백 그라운드
    * denied - 최초 단 한번도 권한을 요청 하지 않은 상태
    * deniedForever - 1 회 권한 요청 후 거절당한 상태 -> 다시는 권한 승인 요청을 보낼수 없다. -> 이럴땐 사용자가 직접 위치 권한을 승인해 주어야 한다.
    * unableToDetermine - 몰루
    * */
    //한번도 요청을 하지 않은 상태
    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();
    }
    //둘다 허용하지 않았을경우
    if (checkedPermission != LocationPermission.always &&
        checkedPermission != LocationPermission.whileInUse) {
      throw Exception('위치 권한을 허가 해주세요.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      //future 안에 있는 함수가 우선 실행됨
      future: checkPermission(),
      //builder 에서 future 의 결과 값을 받아올수 있음.
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {}
        return Column(
          children: [
            Expanded(
              child: GoogleMap(
                initialCameraPosition: initialPosition,
              ),
            ),
          ],
        );
      },
    ));
  }
}
