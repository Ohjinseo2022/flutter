import 'package:flutter/material.dart';
import 'package:stateful_widget/screen/home_screen.dart';
import 'package:stateful_widget/screen/home_screen2.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeScreen(),
            SizedBox(
              height: 32,
            ),
            HomeScreen2(),
          ],
        ),
      ),
    ),
  );
}
