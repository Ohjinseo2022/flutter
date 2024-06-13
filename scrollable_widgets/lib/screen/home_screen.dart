import 'package:flutter/material.dart';
import 'package:scrollable_widgets/layout/main_layoyut.dart';
import 'package:scrollable_widgets/screen/grid_view_screen.dart';
import 'package:scrollable_widgets/screen/list_view_screen.dart';
import 'package:scrollable_widgets/screen/single_child_scroll_view_screen.dart';

class ScreenModel {
  final WidgetBuilder builder;
  final String name;
  ScreenModel({
    required this.builder,
    required this.name,
  });
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final screens = [
    ScreenModel(
      builder: (_) => SingleChildScrollViewScreen(),
      name: "SingleChildScrollViewScreen",
    ),
    ScreenModel(
      builder: (_) => ListViewScreen(),
      name: "ListViewScreen",
    ),
    ScreenModel(
      builder: (_) => GridViewScreen(),
      name: "GridViewScreen",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Home",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: screens
              .map((screen) => ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: screen.builder));
                  },
                  child: Text(screen.name)))
              .toList(),
        ),
      ),
    );
  }
}
