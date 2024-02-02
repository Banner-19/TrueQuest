import 'package:flutter/material.dart';
import 'package:truequest/pages/gamePage.dart';
import 'package:truequest/pages/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrueQuest',
      theme: ThemeData(
        scaffoldBackgroundColor:const Color.fromRGBO(35, 45, 63, 1.0),
        fontFamily: 'ArchitectsDaughter',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

