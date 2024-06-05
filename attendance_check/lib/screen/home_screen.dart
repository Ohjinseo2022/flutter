import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //lat 위도  lng 경도 순서
  final CameraPosition initialPosition = CameraPosition(
    target: LatLng(
      37.5214,
      126.9246,
    ),
    zoom: 15,
  );

  late final GoogleMapController controller;

  bool isAttendance = false;
  bool canIsAtt = false;

  final double okDistance = 100;

  @override
  void initState() {
    super.initState();
    // 이벤트 리스너를 활용하여 값이 변경될때마다 정보를 받아올수있다.
    //listen -> vue에서 watch 느낌
    Geolocator.getPositionStream().listen((event) {
      final start = LatLng(
        37.5214,
        126.9246,
      );
      final end = LatLng(event.latitude, event.longitude);
      //distanceBetween 해당 내장 함수를 사용하면 위지의 차이를 자동으로 계산해준다.
      final distance = Geolocator.distanceBetween(
          start.latitude, start.longitude, end.latitude, end.longitude);
      setState(() {
        if (distance > okDistance) {
          canIsAtt = false;
        } else {
          canIsAtt = true;
        }
      });
    });
  }

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
      appBar: AppBar(
        title: Text(
          "오늘도 출근",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: myLocationPressed,
            icon: Icon(
              Icons.my_location,
            ),
            color: Colors.blue,
          )
        ],
      ),
      body: FutureBuilder(
        //future 안에 있는 함수가 우선 실행됨
        future: checkPermission(),
        //builder 의 파라미터 snapshot 에서 future 의 결과 값을 받아올수 있음.
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {}
          return Column(
            children: [
              Expanded(
                flex: 2,
                child: _GoogleMaps(
                  initialPosition: initialPosition,
                  onMapCreated: onMapCreated,
                  canIsAtt: canIsAtt,
                  okDistance: okDistance,
                ),
              ),
              Expanded(
                child: _IsAttendanceButton(
                  canIsAtt: canIsAtt,
                  isAttendance: isAttendance,
                  onAttendanceCheckPressed: onAttendanceCheckPressed,
                ),
              )
            ],
          );
        },
      ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    // 맵이 생성될때. GoogleMapController 를 사전에 선언해놓은 controller 변수에 초기화 시킨다.
    this.controller = controller;
  }

  onAttendanceCheckPressed() async {
    /*출근하기를 눌렀을때
    * 출근처리 확인 취소 팝업창 호출
    * 현재나의 위치를 받아오고
    * 해당위치가 circles 의 범위에 포함 돼있다면
    * 출근처리를 해주어야 한다.*/
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return AlertDialog(); // 기본 안드로이드스타일의 다이얼로그
        return CupertinoAlertDialog(
          title: Text('출근하기'),
          content: Text('출근을 하시겠습니까?'),
          actions: [
            TextButton(
                onPressed: () {
                  //AlertDialog 는 하나의 페이지로 인식함. pop 처리시 창이 닫히게 할수있음.!
                  Navigator.of(context).pop(false);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                child: Text('취소')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                child: Text('출근하기')),
          ],
        );
      },
    );
    if (result) {
      setState(() {
        isAttendance = true;
      });
    }
  }

  myLocationPressed() async {
    //내 현재위치를 가져와서 지도를 움직여 줘야한다!
    //뭔가 움직이게 처리해주려면 Controller 를 사용
    //내 현재 위치를 받아오는 함수
    final location = await Geolocator.getCurrentPosition();
    //가져온 현위치를 기반으로 맵을 이동시킬수있다.
    controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(location.latitude, location.longitude),
      ),
    );
  }
}

class _GoogleMaps extends StatelessWidget {
  final CameraPosition initialPosition;
  final double okDistance;
  final bool canIsAtt;
  final MapCreatedCallback? onMapCreated;
  const _GoogleMaps(
      {super.key,
      required this.initialPosition,
      required this.onMapCreated,
      required this.okDistance,
      required this.canIsAtt});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: initialPosition,
      /*MapType.satellite 위성지도
                  MapType.terrain normal + 고도에 따른 명함처리
                  MapType.hybrid normal + satellite
                  default MapType.normal
                  * */
      mapType: MapType.normal,
      /*default = false 내위치 표시 기능*/
      myLocationEnabled: true,
      // dafault = true 내위치로 가기 버튼 표시 유무
      myLocationButtonEnabled: false,
      // 줌버튼 활성화 유무 안드로이드 기본 true , ios 기본 false
      zoomControlsEnabled: false,
      onMapCreated: onMapCreated,
      markers: {
        Marker(
          //화면에 그려질 마커의 id 설정 마커가 여러개일때 식별값으로 씀
          markerId: MarkerId('2233'),
          position: LatLng(
            37.5214,
            126.9246,
          ),
        ),
      },
      circles: {
        Circle(
          circleId: CircleId("inDistance"),
          center: LatLng(
            37.5214,
            126.9246,
          ),
          radius: okDistance, //미터 단위
          fillColor: canIsAtt
              ? Colors.blue.withOpacity(0.5)
              : Colors.red.withOpacity(0.5), //원의 색깔
          strokeColor: canIsAtt ? Colors.deepPurpleAccent : Colors.red, //테두리 색깔
          strokeWidth: 2, // 테두리의 너비
        ),
      },
    );
  }
}

class _IsAttendanceButton extends StatelessWidget {
  final bool isAttendance;
  final bool canIsAtt;
  final VoidCallback onAttendanceCheckPressed;
  const _IsAttendanceButton({
    super.key,
    required this.isAttendance,
    required this.canIsAtt,
    required this.onAttendanceCheckPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isAttendance ? Icons.check : Icons.timelapse_outlined,
          color: isAttendance ? Colors.green : Colors.deepPurpleAccent,
        ),
        SizedBox(
          height: 16,
        ),
        if (!isAttendance && canIsAtt)
          OutlinedButton(
            onPressed: onAttendanceCheckPressed,
            style: OutlinedButton.styleFrom(
                foregroundColor: Colors.deepPurpleAccent),
            child: Text(
              '출근하기',
            ),
          ),
      ],
    );
  }
}
