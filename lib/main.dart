import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:homework_2/task1.dart';
import 'package:homework_2/task3.dart';

void main(List<String> args) {
  runApp(Hometask());
}

class Hometask extends StatelessWidget {
  const Hometask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageScreen(),
    );
  }
}
