import 'package:calender_scheduler/component/custom_text_field.dart';
import 'package:calender_scheduler/const/color.dart';
import 'package:calender_scheduler/model/schedule.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDay;
  const ScheduleBottomSheet({super.key, required this.selectedDay});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

// List<Map<String, dynamic>> -> 이런방식은 권장하지않음
// TypeScript 처럼 규격을 정해놓고 관리하는게 맞음
class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  int? startTime;
  int? endTime;
  String? content;

  String selectedColor = categoryColors.first;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 600,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _Time(
                  onStartSaved: onTimeSaved,
                  onStartValidate: onTimeValidate,
                  onEndSaved: onTimeSaved,
                  onEndValidate: onTimeValidate,
                ),
                SizedBox(
                  height: 8,
                ),
                _Content(
                  onSaved: onContentSaved,
                  onValidate: onContentValidate,
                ),
                SizedBox(
                  height: 8,
                ),
                _Categories(
                    selectedColor: selectedColor,
                    onChangeSelectedColor: onChangeSelectedColor),
                SizedBox(
                  height: 8,
                ),
                _SaveButton(onPressed: onSavePressed),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTimeSaved(String type, String? val) {
    if (val == null) {
      return;
    }
    type == 'start' ? startTime = int.parse(val) : endTime = int.parse(val);
  }

  String? onTimeValidate(String? val) {
    if (val == null || val == '') {
      return '값을 입력 해주세요!';
    }
    if (int.tryParse(val) == null) {
      return '숫자를 입력해주세요!';
    }
    final time = int.parse(val);
    if (time > 24 || time < 0) {
      return '0과 24 사이의 숫자를 입력해주세요!';
    }
    return null;
  }

  String? onEndTimeValidate(String? val) {
    if (val == null || val == '') {
      return '값을 입력 해주세요!';
    }
    if (int.tryParse(val) == null) {
      return '숫자를 입력해주세요!';
    }
    final time = int.parse(val);
    if (time > 24 || time < 0) {
      return '0과 24 사이의 숫자를 입력해주세요!';
    }
    return null;
  }

  String? onEndValidate(String? val) {
    return null;
  }

  void onContentSaved(String? val) {
    if (val == null) {
      return;
    }
    content = val;
  }

  String? onContentValidate(String? val) {
    if (val == null || val == '') {
      return '내용을 입력해주세요!';
    }
    if (val.length < 5) {
      return '5자 이상을 입력해주세요!';
    }
    return null;
  }

  void onChangeSelectedColor(String color) {
    setState(() {
      selectedColor = color;
    });
  }

  void onSavePressed() {
    final validate = formKey.currentState!.validate();
    if (validate) {
      formKey.currentState!.save();
      print(startTime);
      print(endTime);
      print(content);
      print(selectedColor);
      // final schedule = ScheduleTable(
      //   id: 999,
      //   startTime: startTime!,
      //   endTime: endTime!,
      //   content: content!,
      //   date: widget.selectedDay,
      //   color: selectedColor,
      //   createdAt: DateTime.now().toUtc(),
      // );
      // Navigator.of(context).pop(schedule);
    }
  }
}

typedef OnTextFieldSaved = void Function(String type, String? val);
typedef OnTextFieldValidate = String? Function(String type, String? val);

class _Time extends StatelessWidget {
  final OnTextFieldSaved onStartSaved;
  final OnTextFieldSaved onEndSaved;
  final FormFieldValidator<String> onStartValidate;
  final FormFieldValidator<String> onEndValidate;
  // final OnTextFieldValidate onStartValidate;
  // final OnTextFieldValidate onEndValidate;

  // formkey 프로젝트 전체에 단하나의 값만 존재하는 키를 만드는데 form 의 상태를 저장해준다.
  // final GlobalKey<FormState> formKey = GlobalKey();

  const _Time({
    super.key,
    required this.onEndSaved,
    required this.onEndValidate,
    required this.onStartSaved,
    required this.onStartValidate,
  });

  @override
  Widget build(BuildContext context) {
    //데이터를 관리하고 싶은 곳에 Form 으로 감싸준다.
    return
        // Form(
        // key: formKey,
        // child:
        Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                label: '시작 시간',
                onSaved: (String? val) {
                  onStartSaved('start', val);
                },
                // validator: (String? val) {
                //   final result = onStartValidate('start', val);
                //   return result;
                // },
                validator: onStartValidate,
              ),
            ),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: CustomTextField(
                label: '마감 시간',
                onSaved: (String? val) {
                  onEndSaved('end', val);
                },
                // validator: (String? val) {
                //   final result = onEndValidate('end', val);
                //   return result;
                // },
                validator: onEndValidate,
              ),
            ),
          ],
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     print(formKey);
        //     // 해당 Form 위젯이 감싸고 있는 모든 vaildator 함수 실행
        //     // 만약 해당 함수가 실행중 오류가 1개도 없었다면 true 반환 아니라면 false 반환
        //     final validated = formKey.currentState!.validate(); //검증하다
        //     print(validated);
        //     if (validated) {
        //       //-> 해당 Form 위젯이 감싸고 있는 모든 onSaved 함수 실행
        //       formKey.currentState!.save(); //저장하다
        //     }
        //   },
        //   child: Text('save'),
        // )
      ],
      // ),
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> onValidate;
  const _Content({super.key, required this.onSaved, required this.onValidate});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
        onSaved: onSaved,
        validator: onValidate,
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
  final VoidCallback onPressed;
  const _SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
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
