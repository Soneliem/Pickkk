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
  double _loginHeight = 0;
  var _backgroundColor = const Color(0xff251F34);
  final _dropdownValues = {
    "na": "North America",
    "ap": "Asia Pacific",
    "eu": "Europe",
    "ko": "Korea",
    "br": "Brazil",
    "latam": "Latin America",
  };
  String _selectedRegion = "na";

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    _loginHeight = windowHeight - 320;

    switch (_pageState) {
      case 0:
        _loginYOffset = windowHeight;
        _backgroundColor = const Color(0xff251F34);
        break;
      case 1:
        _backgroundColor = const Color(0xFF3B324E);
        _loginYOffset = 270;
        _loginHeight = windowHeight - 320;
        break;
    }

    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              _pageState = 0;
            });
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
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
                    child: Text(
                      'Status',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
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
          height: _loginHeight,
          padding: const EdgeInsets.all(32),
          transform: Matrix4.translationValues(0, _loginYOffset, 1),
          decoration: const BoxDecoration(
              color: Color(0xff251F34),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: GestureDetector(
            onVerticalDragStart: (_) => setState(() {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              _pageState = 0;
            }),
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: const Text(
                        "Login With Riot Credentials",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    InputWithIcon(
                      icon: Icons.person,
                      hint: "Enter Username...",
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InputWithIcon(
                      icon: Icons.vpn_key,
                      hint: "Enter Password...",
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 65,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffbc7c7c7), width: 2),
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                              width: 60,
                              child: Icon(
                                Icons.map,
                                size: 20,
                                color: Color(0xffbb9b9b9),
                              )),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: Color(0xff14DAE2),
                                style: (TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16)),
                                items: _dropdownValues.entries.map((entry) {
                                  return DropdownMenuItem(
                                    child: Text(entry.value),
                                    value: entry.key,
                                  );
                                }).toList(),
                                isExpanded: false,
                                hint: Text(
                                  _dropdownValues.values.first,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                value: _selectedRegion,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedRegion = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Button(
                      btnText: "Log In",
                      isFull: true,
                    ),
                  ],
                )
              ],
            ),
          ),
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
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff14DAE2), width: 2),
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
          border: Border.all(color: const Color(0xffbc7c7c7), width: 2),
          borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: <Widget>[
          SizedBox(
              width: 60,
              child: Icon(
                widget.icon,
                size: 20,
                color: Color(0xffbb9b9b9),
              )),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  border: InputBorder.none,
                  hintText: widget.hint,
                  hintStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400)),
              style: (const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w400)),
            ),
          )
        ],
      ),
    );
  }
}
