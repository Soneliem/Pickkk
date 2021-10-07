// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  int _pageState = 0;
  double windowWidth = 0;
  double windowHeight = 0;
  double _loginYOffset = 0;
  var _backgroundColor = const Color(0xff251F34);

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    switch (_pageState) {
      case 0:
        _loginYOffset = windowHeight;
        _backgroundColor = const Color(0xff251F34);
        break;
      case 1:
        _backgroundColor = const Color(0xFF3B324E);
        _loginYOffset = 270;
        break;
    }

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _pageState = 0;
            });
          },
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.fastLinearToSlowEaseIn,
            color: _backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 100),
                      child: const Text(
                        "Account",
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
                        "Log in using your Riot Login",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  ],
                ),
                Container(
                  child: const Center(
                    child: Text('Status'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(32),
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _pageState = 1;
                        });
                      },
                      child: Button(
                        btnText: "Log In Again",
                        isFull: false,
                      )),
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.fastLinearToSlowEaseIn,
          padding: const EdgeInsets.all(32),
          transform: Matrix4.translationValues(0, _loginYOffset, 1),
          child: Column(
            children: <Widget>[
              InputWithIcon(
                icon: Icons.email,
                hint: "Enter Username...",
              ),
              SizedBox(
                height: 10,
              ),
              InputWithIcon(
                icon: Icons.vpn_key,
                hint: "Enter Password...",
              ),
              SizedBox(
                height: 10,
              ),
              Button(
                btnText: "Log In",
                isFull: true,
              )
            ],
          ),
          decoration: BoxDecoration(
              color: const Color(0xff251F34),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        )
      ],
    );
  }
}

class Button extends StatefulWidget {
  final String btnText;
  final bool isFull;
  Button({required this.btnText, required this.isFull});

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  Color btnColor = Color.fromRGBO(0, 0, 0, 0);
  Color btnTextColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    if (widget.isFull) {
      btnColor = Color(0xff14DAE2);
      btnTextColor = Colors.black;
    }
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xff14DAE2), width: 2),
          color: btnColor,
          borderRadius: BorderRadius.circular(50)),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(
              color: btnTextColor, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class InputWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  InputWithIcon({required this.icon, required this.hint});

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFBC7C7C7), width: 2),
          borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: <Widget>[
          Container(
              width: 60,
              child: Icon(
                widget.icon,
                size: 20,
                color: Color(0xFFBB9B9B9),
              )),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  border: InputBorder.none,
                  hintText: widget.hint),
              style: (TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400
              )),
            ),
          )
        ],
      ),
    );
  }
}
