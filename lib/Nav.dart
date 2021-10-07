// ignore_for_file: prefer_const_constructors, file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pickkk/Pages/Account.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Account(),
    Text('Home'),
    Text('Settings')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color(0xff251F34),
          color: Color(0xFF3B324E),
          height: 50,
          items: const <Widget>[
            Icon(
              Icons.account_circle,
              size: 30,
              color: Color(0xff14DAE2),
            ),
            Icon(
              Icons.home,
              size: 30,
              color: Color(0xff14DAE2),
            ),
            Icon(
              Icons.settings,
              size: 30,
              color: Color(0xff14DAE2),
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
