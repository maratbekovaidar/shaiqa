import 'package:flutter/material.dart';
import 'features/main/views/screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Shaiqa',
      debugShowCheckedModeBanner: false,
      home: MainPage()
    );
  }
}