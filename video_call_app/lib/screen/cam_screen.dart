import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:video_call_app/const/keys.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({super.key});

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  RtcEngine? engine;
  int uid = 0;
  int? remoteUid;
  //agora 엔진 초기화 방법
  Future<void> init() async {
    //permission_handler 패키지를 통해 권한가져오는 설정을 쉽게 도와준다..!
    final resp = await [Permission.camera, Permission.microphone].request();

    final cameraPermission = resp[Permission.camera];
    final microphonePermission = resp[Permission.microphone];
    if (cameraPermission != PermissionStatus.granted ||
        microphonePermission != PermissionStatus.granted) {
      throw '카메라 또는 마이크 권한이 없습니다.';
    }
    if (engine == null) {
      engine = createAgoraRtcEngine();
      //엔진생성
      await engine!.initialize(
        RtcEngineContext(
          appId: appId,
        ),
      );

      engine!.registerEventHandler(
        RtcEngineEventHandler(
          //내가 성공적으로 채널에 진입했을떄
          onJoinChannelSuccess: (
            RtcConnection connection,
            int elapsed,
          ) {},
          //내가 채널을 나갔을때
          onLeaveChannel: (
            RtcConnection connection,
            RtcStats stats,
          ) {},
          //상대방이 들어왔을때
          onUserJoined: (
            //  연결정보
            RtcConnection connection,
            // 상대방 uid
            int remoteUid,
            //  들어온시간
            int elapsed,
          ) {
            print('-----------UserJoined------------');
            print(remoteUid);
            setState(() {
              this.remoteUid = remoteUid;
            });
          },
          //상대방이 나갈떄
          onUserOffline: (
            //연결 정보
            RtcConnection connection,
            //상대방 uid
            int remoteUid,
            //연결 끊킨 이유
            UserOfflineReasonType reason,
          ) {
            setState(() {
              this.remoteUid = null;
            });
          },
        ),
      );
      //영상 활성화
      await engine!.enableVideo();
      //프리뷰 활성화
      await engine!.startPreview();
      //채널 송출옵션 설정가능함 !
      ChannelMediaOptions options = ChannelMediaOptions();
      //채널 입장
      await engine!.joinChannel(
        token: token, //
        channelId: channelName, //채널이름
        uid: uid, // 방에 들어갔을때 아이디 정보
        options: options,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LIVE"),
      ),
      //위로 정렬할때 스택 위젝을 씀
      body: FutureBuilder<void>(
          future: init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            }
            return Stack(
              children: [
                Container(child: renderMainView()),
                Container(
                  width: 120,
                  height: 160,
                  //화면을 보는 방법
                  child: AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: engine!,
                      canvas: VideoCanvas(
                        uid: uid,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  // top: ,
                  left: 16,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      //채널 퇴장
                      engine!.leaveChannel();
                      //엔진 삭제
                      engine!.release();
                      Navigator.of(context).pop();
                    },
                    child: Text("나가기"),
                  ),
                ),
              ],
            );
          }),
    );
  }

  renderMainView() {
    if (remoteUid == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: engine!,
        canvas: VideoCanvas(
          uid: remoteUid, //상태방 uid 넣어줘야함
        ),
        connection: RtcConnection(
          channelId: channelName,
        ),
      ),
    );
  }
}
