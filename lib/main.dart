import 'package:flutter/material.dart';
import 'features/main/views/screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shaiqa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: const Color(0xff0F3460),
        scaffoldBackgroundColor: const Color(0xff0F3460),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color(0xff1A1A2E)
        )
      ),
      home: const MainPage()
    );
  }
}