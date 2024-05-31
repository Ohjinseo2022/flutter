import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video == null
          ? _VideoSelector(
              onLogoTap: onLogoTap,
            )
          : _VideoPlayer(
              video: video!,
              onPickAnotherVideo: onLogoTap,
            ),
    );
  }

  onLogoTap() async {
    print('비디오 선택');
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
      //   ImageSource.camera
    );
    print(video); // Instance of 'Xfile' 리턴
    setState(() {
      this.video = video;
    });
  }
}

class _VideoSelector extends StatelessWidget {
  final VoidCallback onLogoTap;
  const _VideoSelector({super.key, required this.onLogoTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // gradient: RadialGradient(
        //   //원형 그라데이션
        //   center: Alignment.center, // 그라데이션 시작 위치
        //   radius: 0.5,
        //   colors: [
        //     Colors.red,
        //     Colors.green,
        //   ],
        // ),
        gradient: LinearGradient(
          //1자 그라데이션
          begin: Alignment.topCenter, //시작 기준
          end: Alignment.bottomCenter, // 종료 기준
          // stops: [
          //   // 색깔의 비중 색깔의 갯수만큼 리스트 주가 가능
          //   0.5,
          //   0.8,
          // ],
          colors: [
            Color(0xFF2A3A7C),
            Color(0xFF000118),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _logo(
            onTap: onLogoTap,
          ),
          SizedBox(
            height: 28,
          ),
          _Title(),
        ],
      ),
    );
  }
}

class _logo extends StatelessWidget {
  final VoidCallback onTap;
  const _logo({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        "asset/image/logo.png",
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 32.0,
      fontWeight: FontWeight.w300,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "VIDEO",
          style: textStyle,
        ),
        Text(
          "PLAYER",
          //기존에 입력된 값들을 그대로 가져온다. 이미 존재하는 값들은 덮어 쓰기가된다.
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _VideoPlayer extends StatefulWidget {
  final XFile video;
  final VoidCallback onPickAnotherVideo;
  const _VideoPlayer({
    super.key,
    required this.video,
    required this.onPickAnotherVideo,
  });

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  late VideoPlayerController videoPlayerController;
  bool showIcons = true;
  @override
  void initState() {
    super.initState();
    initializeController();
  }

  @override
  void didUpdateWidget(covariant _VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // oldWiget은 과거 위젯 임 과거 위젯정보와 기존 위젯 정복가 다르다면
    // initializeController 의 정보를 새로 갱신해줄 필요가 있음.
    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  initializeController() async {
    //asset , file, network 등 다양한데사 가져올수 있음
    // 선택한 영상의 경로
    videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
    );
    await videoPlayerController.initialize();
    videoPlayerController.addListener(() {
      setState(() {});
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        showIcons = !showIcons;
      }),
      child: Center(
        child: AspectRatio(
          //크기 조절용
          aspectRatio: videoPlayerController.value.aspectRatio,
          //동영상을 컨트롤하기위한 위젯을 추가하기 위해 스택을 사용
          child: Stack(
            children: [
              //children 에 넣는 순서대로 스택구조(처음께 제일 아래로) 위젯이 생성된다.
              VideoPlayer(
                videoPlayerController,
              ),
              if (showIcons)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.3),
                ),
              if (showIcons)
                _PlayButton(
                  onForwardPressed: onForwardPressed,
                  onPlayPressed: onPlayPressed,
                  onReversePressed: onReversePressed,
                  isPlaying: videoPlayerController.value.isPlaying,
                ),
              if (showIcons)
                _PlaySlier(
                  videoMaxPosition: videoPlayerController.value.duration,
                  videoPosition: videoPlayerController.value.position,
                  onSliderChanged: onSliderChanged,
                ),
              if (showIcons)
                _PickAnotherVideo(
                  onPressed: widget.onPickAnotherVideo,
                ),
            ],
          ),
        ),
      ),
    );
  }

  //복습해보기
  onSliderChanged(double val) {
    final position = Duration(seconds: val.toInt());
    videoPlayerController.seekTo(position);
  }

  onForwardPressed() {
    final maxPosition = videoPlayerController.value.duration; //최대 길이
    final currentPosition = videoPlayerController.value.position;

    Duration position = maxPosition;
    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }
    videoPlayerController.seekTo(position);
  }

  onPlayPressed() {
    setState(() {
      videoPlayerController.value.isPlaying //현재 재생중 유무 체크
          ? videoPlayerController.pause()
          : videoPlayerController.play();
    });
  }

  onReversePressed() {
    final currentPosition = videoPlayerController.value.position;
    Duration position = Duration();
    if (currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }
    videoPlayerController.seekTo(position);
  }
}

class _PlayButton extends StatelessWidget {
  final VoidCallback onReversePressed;
  final VoidCallback onPlayPressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;
  const _PlayButton({
    super.key,
    required this.onForwardPressed,
    required this.onPlayPressed,
    required this.onReversePressed,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            color: Colors.white,
            onPressed: onReversePressed,
            icon: Icon(
              Icons.rotate_left,
            ),
          ),
          IconButton(
            color: Colors.white,
            onPressed: onPlayPressed,
            icon: Icon(
              !isPlaying ? Icons.play_arrow : Icons.pause,
            ),
          ),
          IconButton(
            color: Colors.white,
            onPressed: onForwardPressed,
            icon: Icon(
              Icons.rotate_right,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaySlier extends StatelessWidget {
  final Duration videoPosition;
  final Duration videoMaxPosition;
  final ValueChanged<double> onSliderChanged;
  const _PlaySlier({
    super.key,
    required this.videoPosition,
    required this.videoMaxPosition,
    required this.onSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Text(
              //길이 단위 00 으로 맞추기
              '${videoPosition.inMinutes.toString().padLeft(2, '0')}'
              ':'
              '${(videoPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Slider(
                value: videoPosition.inSeconds.toDouble(),
                max: videoMaxPosition.inSeconds.toDouble(),
                onChanged: onSliderChanged,
              ),
            ),
            Text(
              '${videoMaxPosition.inMinutes.toString().padLeft(2, '0')}:${(videoMaxPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PickAnotherVideo extends StatelessWidget {
  final VoidCallback onPressed;
  const _PickAnotherVideo({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
        color: Colors.white,
        onPressed: onPressed,
        icon: Icon(
          Icons.photo_camera_back,
        ),
      ),
    );
  }
}
