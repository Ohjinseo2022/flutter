import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              //onPressed : null, ->> disable 처리가능
              onPressed: () {},
              // 버튼 스타일을 변경할떄. 버튼 이름과 동일한 클래스를 호출.
              // 클래스 내부에 styleFrom()함수를 초출하여 스타일 변경가능
              style: ElevatedButton.styleFrom(
                //배경 색깔
                backgroundColor: Colors.red,
                disabledBackgroundColor: Colors.grey,
                //배경 위의 색깔
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.red,
                // 그림자 색깔
                shadowColor: Colors.green,
                // 그림자 높이
                elevation: 10,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
                padding: EdgeInsets.all(20),
                //테두리 디자인
                side: BorderSide(
                  color: Colors.deepPurpleAccent,
                  width: 12,
                ),
                // minimumSize: Size(150, 50), // 최소 사이즈
                // maximumSize: Size(100, 150), // 최대 사이즈
                // fixedSize: Size(100, 150), //고정 사이즈
              ),
              child: Text("Elevated Button"),
            ),
            OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                /*Material State
                hovered - 호버링 상태(마우스 커서를 올려놓은 상태) -- 모바일에선 의미없긴함
                focused - 포커스 됐을떄 (텍스트 필드)
                pressed - 놀렀을때 (O)
                dragged - 드래그 됐을떄
                selected - 선택 됐을떄 (체크박스, 라디오 버튼)
                scrollUnder - 다른 컴포넌트 밑으로 스크롤링 됐을때
                disabled - 비활성화 됐을떄 (O)
                error - 에러 상태일때
                * */
                backgroundColor: MaterialStateProperty.all(Colors.red),
                minimumSize: MaterialStateProperty.all(
                  Size(200, 100),
                ),
              ),
              child: Text("Outlined Button"),
            ),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                  //상태에 따른 스타일 변화를 주려고 한다면  MaterialStateProperty.resolveWith 사용
                  backgroundColor: MaterialStateProperty.resolveWith(
                    //Set<MaterialState> states
                    (states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.red;
                      }
                      return Colors.black;
                    },
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith((states) =>
                      states.contains(MaterialState.pressed)
                          ? Colors.black
                          : Colors.red),
                  minimumSize: MaterialStateProperty.resolveWith((states) =>
                      states.contains(MaterialState.pressed)
                          ? Size(200, 50)
                          : Size(100, 50))),
              child: Text("Text Button"),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                // shape: StadiumBorder(),//기본 값
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(10),// 라운드 설정가능
                // ), // 사각형
                // shape: BeveledRectangleBorder(
                //   borderRadius: BorderRadius.circular(10),
                // ), //다각형 처럼 가능
                // shape: ContinuousRectangleBorder(
                //   borderRadius: BorderRadius.circular(32),
                // ), //자연스러운 ? 각도조절
                shape: CircleBorder(
                  eccentricity:
                      1, //원의 크기 ? 각도 ? 조절 0~1 사이의 값 넣기 가능 0에 가까울수록 원에 가까움
                ),
              ),
              child: Text('Shape'),
            ),
            ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.keyboard_alt_outlined),
                label: Text("키보드"))
          ],
        ),
      ),
    );
  }
}
