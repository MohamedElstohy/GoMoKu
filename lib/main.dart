import 'package:flutter/material.dart';

import 'splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Color(0xFF15202b),
        accentColor: Color(0xFFFFFFFF),
        fontFamily: 'Flower',
      ),
      home: SplashScreen(),
    );
  }
}

