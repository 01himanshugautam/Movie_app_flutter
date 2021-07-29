import 'package:flutter/material.dart';
import 'package:task_fetch_data_imdb/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMDB',
      home: Home(),
    );
  }
}
