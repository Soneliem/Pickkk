// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../custom.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: const Text(
                "Pickkk!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: const Text(
                "Remotely select your agent",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ],
        ),
        Column(
          children: [
            Button(
              btnText: "Start Auto-Check",
              onTap: () {},
              isFull: true,
            ),
            Button(
              btnText: "Check Manually",
              onTap: () {},
              isFull: false,
            ),
          ],
        ),
      ],
    );
  }
}
