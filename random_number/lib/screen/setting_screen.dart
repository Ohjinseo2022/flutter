import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:random_number/component/number_to_image.dart';
import 'package:random_number/constant/color.dart';

class SettingScreen extends StatefulWidget {
  final int maxNumber;
  const SettingScreen({super.key, required this.maxNumber});
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double maxNumber = 1000;
  @override
  void initState() {
    super.initState();
    //widget은 createState 단계에서 사용 불가능하기 때문에 initState 단계에서 설정해준다!
    maxNumber = widget.maxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Number(
                maxNumber: maxNumber,
              ),
              _Slider(
                value: maxNumber,
                updateNumber: updateNumber,
              ),
              _Button(onPressed: onSaveMaxNumber),
            ],
          ),
        ),
      ),
    );
  }

  void updateNumber(double newVal) {
    setState(() {
      maxNumber = newVal;
    });
  }

  void onSaveMaxNumber() {
    setState(() {
      Navigator.of(context).pop(
        maxNumber.toInt(),
      );
    });
  }
}

class _Number extends StatelessWidget {
  final double maxNumber;
  const _Number({required this.maxNumber, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: NumberToImage(
          number: maxNumber.toInt(),
        ),
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  final ValueChanged<double> updateNumber;
  final double value;
  const _Slider({super.key, required this.value, required this.updateNumber});
  //, required this.updateNumber

  @override
  Widget build(BuildContext context) {
    return Slider(
        value: value,
        max: 100000,
        min: 1000,
        activeColor: redColor,
        onChanged: (double newValue) {
          print(newValue);
          updateNumber(newValue);
          // setState(() {
          //   widget.updateNumber(newValue);
          // });
        });
  }
}

class _Button extends StatelessWidget {
  final VoidCallback onPressed;
  const _Button({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: redColor,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text('저장!'),
    );
  }
}
