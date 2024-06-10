import 'package:calender_scheduler/const/color.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;
  final Color color;
  const ScheduleCard({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.content,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        //IntrinsicHeight -> 크기를 정하지 않은 위젯들을
        // 가장 큰 사이즈를 가진 위젯을 기준으로 크기를 맞춰주는 기능
        // 보통 Row 에선 IntrinsicHeight , Column 에서는 IntrinsicWidth
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // 1-> 01
                    // 10 -> 10
                    '${startTime.toString().padLeft(2, "0")}:00',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${endTime.toString().padLeft(2, "0")}:00',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: Text('${content}'),
              ),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
