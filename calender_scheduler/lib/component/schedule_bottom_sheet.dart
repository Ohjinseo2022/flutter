import 'package:calender_scheduler/component/custom_text_field.dart';
import 'package:calender_scheduler/const/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

// List<Map<String, dynamic>> -> 이런방식은 권장하지않음
// TypeScript 처럼 규격을 정해놓고 관리하는게 맞음
class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  String selectedColor = categoryColors.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 600,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
          child: Column(
            children: [
              _Time(),
              SizedBox(
                height: 8,
              ),
              _Content(),
              SizedBox(
                height: 8,
              ),
              _Categories(
                  selectedColor: selectedColor,
                  onChangeSelectedColor: onChangeSelectedColor),
              SizedBox(
                height: 8,
              ),
              _SaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  void onChangeSelectedColor(String color) {
    setState(() {
      selectedColor = color;
    });
  }
}

class _Time extends StatelessWidget {
  const _Time({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            label: '시작 시간',
          ),
        ),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: CustomTextField(
            label: '마감 시간',
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
      ),
    );
  }
}

// 함수에 특정 파라미터를 받고 최 상위에서 상태 관리를 하고싶을떄 이런 방식을 사용한다.
typedef OnColorSelected = void Function(String color);

class _Categories extends StatelessWidget {
  final String selectedColor;
  final OnColorSelected onChangeSelectedColor;
  const _Categories(
      {super.key,
      required this.selectedColor,
      required this.onChangeSelectedColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: categoryColors
          .map(
            (color) => GestureDetector(
              onTap: () {
                onChangeSelectedColor(color);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(int.parse('FF${color}', radix: 16)),
                    shape: BoxShape.circle,
                    border: color == selectedColor
                        ? Border.all(
                            color: Colors.black,
                            width: 4.0,
                          )
                        : null,
                  ),
                  width: 32,
                  height: 32,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text('저장'),
          ),
        ),
      ],
    );
  }
}
