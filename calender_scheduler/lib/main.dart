import 'package:calender_scheduler/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();

  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
