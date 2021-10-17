// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Settings',
      style: TextStyle(color: Colors.white),
    ));
  }
}
