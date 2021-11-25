import 'package:flutter/material.dart';
import 'package:pickkk/nav.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pickkk!',
      theme: ThemeData(
          fontFamily: "Nunito",
          backgroundColor: const Color(0xff251F34),
          scaffoldBackgroundColor: const Color(0xff251F34)),
      home: Nav(),
    );
  }
}
