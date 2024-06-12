import 'package:calender_scheduler/component/custom_text_field.dart';
import 'package:calender_scheduler/const/color.dart';
import 'package:calender_scheduler/database/drift.dart';
import 'package:calender_scheduler/model/schedule.dart';
import 'package:drift/drift.dart' hide Column; // 겹치는 이름이 있을때 숨기는 방법
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final int? id;
  final DateTime selectedDay;
  // 만약에 기존 아이디가 입력들어오면 기존 일정을 불러온다
  const ScheduleBottomSheet({super.key, required this.selectedDay, this.id});

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
  void initState() {
    // TODO: implement initState
    super.initState();
    initCategory();
  }

  //?? 어차피 바뀌는거 아닌가 싶긴한데 강의에서 이렇게나옴
  initCategory() async {
    if (widget.id != null) {
      final res = await GetIt.I<AppDatabase>().getScheduleById(widget.id!);
      setState(() {
        selectedColor = res.color;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ScheduleTableData>(
        future: widget.id == null
            ? null
            : GetIt.I<AppDatabase>().getScheduleById(widget.id!),
        builder: (context, snapshot) {
          //데이터를 가져오는 중이라면. 로딩창을 보여주게 한다!
          if (widget.id != null &&
              snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final data = snapshot.data;

          return Container(
            color: Colors.white,
            height: 600,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      _Time(
                        onStartSaved: onTimeSaved,
                        onStartValidate: onTimeValidate,
                        onEndSaved: onTimeSaved,
                        onEndValidate: onTimeValidate,
                        startTimeInitValue: data?.startTime.toString(),
                        endTimeInitValue: data?.endTime.toString(),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      _Content(
                        onSaved: onContentSaved,
                        onValidate: onContentValidate,
                        initialValue: data?.content.toString(),
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
        });
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

  void onSavePressed() async {
    final validate = formKey.currentState!.validate();
    if (validate) {
      formKey.currentState!.save();
      print(startTime);
      print(endTime);
      print(content);
      print(selectedColor);
      //필요한 곳에서 사용
      final dataBase = GetIt.I<AppDatabase>();
      final result = widget?.id == null
          ? await dataBase.createSchedule(
              ScheduleTableCompanion(
                startTime: Value(startTime!),
                endTime: Value(endTime!),
                content: Value(content!),
                color: Value(selectedColor),
                date: Value(widget.selectedDay),
              ),
            )
          : await dataBase.updateScheduleById(
              widget.id!,
              ScheduleTableCompanion(
                startTime: Value(startTime!),
                endTime: Value(endTime!),
                content: Value(content!),
                color: Value(selectedColor),
                date: Value(widget.selectedDay),
              ));
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
      Navigator.of(context).pop(result);
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
  final String? startTimeInitValue;
  final String? endTimeInitValue;
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
    this.startTimeInitValue,
    this.endTimeInitValue,
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
                initialValue: startTimeInitValue,
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
                initialValue: endTimeInitValue,
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
  final String? initialValue;
  const _Content(
      {super.key,
      required this.onSaved,
      required this.onValidate,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
        onSaved: onSaved,
        validator: onValidate,
        initialValue: initialValue,
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
