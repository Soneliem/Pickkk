import 'package:flutter/material.dart';
import 'package:pickkk/Nav.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: "Nunito",
          backgroundColor: Color(0xff251F34),
          scaffoldBackgroundColor: Color(0xff251F34)),
      home: Nav(),
    );
  }
}
