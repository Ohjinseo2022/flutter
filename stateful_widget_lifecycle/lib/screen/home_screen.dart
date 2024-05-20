import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool show = false;
  Color color = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            show
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        color = color == Colors.red ? Colors.blue : Colors.red;
                      });
                    },
                    child: CodeFactoryWidget(color: color))
                : const SizedBox(
                    height: 50,
                  ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  //state class 를 dirty상태로 변경
                  show = !show;
                });
              },
              child: Text("${show ? '누르면 사라짐' : '누르면 나옴'}"),
            )
          ],
        ),
      ),
    );
  }
}

//StatefulWidget
class CodeFactoryWidget extends StatefulWidget {
  final Color color;
  CodeFactoryWidget({super.key, required this.color}) {
    print("1) Stateful Widget Constructor");
  }

  @override
  State<CodeFactoryWidget> createState() {
    print("2) Stateful Widget CreateState");
    return _CodeFactoryWidgetState();
  }
}

//Stateful Class
class _CodeFactoryWidgetState extends State<CodeFactoryWidget> {
  // Color color = Colors.red;
  @override
  void initState() {
    print("3) Stateful Widget InitState");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("4) Stateful Widget DidChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("5) Stateful Widget Build");
    // return GestureDetector(
    //   onTap: () {
    //     setState(() {
    //       color = color == Colors.red ? Colors.blue : Colors.red;
    //     });
    //   },
    //   child: Container(
    //     width: 50,
    //     height: 50,
    //     color: color,
    //   ),
    // );
    return Container(
      color: widget.color,
      width: 50,
      height: 50,
    );
  }

  @override
  void deactivate() {
    print("6) Stateful Widget Deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("7) Stateful Widget Dispose");
    super.dispose();
  }
}
