// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:valorant_client/valorant_client.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../vclient.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String IGN = "";
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  double windowHeight = 0;
  double windowWidth = 0;

  var _backgroundColor = const Color(0xff251F34);
  final List<Regions> _dropdownValues = <Regions>[
    const Regions(Region.na, 'North America'),
    const Regions(Region.ap, 'Asia Pacific'),
    const Regions(Region.eu, 'Europe'),
    const Regions(Region.ko, 'Korea'),
    const Regions(Region.na, 'Brazil'),
    const Regions(Region.na, 'Latin America'),
  ];

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isNotAuthenticated = true;
  double _loginHeight = 0;
  double _loginYOffset = 0;
  int _pageState = 0;
  Regions _selectedRegion = const Regions(Region.na, "North America");

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<bool> forceAuth(
      String username, String password, Region region) async {
    bool output;
    setState(() {
      _isLoading = true;
    });

    await authenticate(username, password, region);

    final user = await client.playerInterface.getPlayer();
    if (user != null) {
      IGN = user.gameName;
      output = true;
    } else {
      output = false;
    }

    setState(() {
      _isLoading = false;
    });
    return output;
  }

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;

    _loginHeight = windowHeight;

    switch (_pageState) {
      case 0:
        _loginYOffset = windowHeight;
        _backgroundColor = const Color(0xff251F34);
        _loginHeight = 0;
        break;
      case 1:
        _backgroundColor = const Color(0xFF3B324E);
        _loginYOffset = windowHeight / 4;
        _loginHeight = windowHeight - _loginYOffset - 50;
        break;
    }

    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return KeyboardDismissOnTap(
        child: LoadingOverlay(
          isLoading: _isLoading,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      const Center(
                        child: Text(
                          'Status',
                          style: TextStyle(color: Colors.white, fontSize: 24),
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
                              isFull: _isNotAuthenticated,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                height: isKeyboardVisible ? windowHeight - 50 : _loginHeight,
                padding: const EdgeInsets.all(32),
                transform: Matrix4.translationValues(
                    0, isKeyboardVisible ? 50 : _loginYOffset, 1),
                decoration: const BoxDecoration(
                  color: Color(0xff251F34),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                child: GestureDetector(
                  onVerticalDragStart: (_) => setState(() {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    _pageState = 0;
                  }),
                  behavior: HitTestBehavior.opaque,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      _pageState = 0;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Color(0xff14DAE2),
                                  ),
                                ),
                                const Expanded(
                                  child: Text(
                                    "Login With Riot Credentials",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            InputWithIcon(
                              icon: Icons.person,
                              hint: "Enter Username...",
                              controller: usernameController,
                              obscure: false,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            InputWithIcon(
                              icon: Icons.vpn_key,
                              hint: "Enter Password...",
                              controller: passwordController,
                              obscure: true,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 65,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xffbc7c7c7),
                                      width: 2),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                      width: 60,
                                      child: Icon(
                                        Icons.map_rounded,
                                        size: 20,
                                        color: Color(0xffbb9b9b9),
                                      )),
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<Regions>(
                                        dropdownColor: const Color(0xff14DAE2),
                                        style: (const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16)),
                                        items: _dropdownValues
                                            .map((Regions region) {
                                          return DropdownMenuItem<Regions>(
                                            child: Text(region.name),
                                            value: region,
                                          );
                                        }).toList(),
                                        isExpanded: false,
                                        hint: Text(
                                          _dropdownValues.first.name,
                                          style: const TextStyle(
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
                                  const SizedBox(
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
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (!await forceAuth(
                                      usernameController.text,
                                      passwordController.text,
                                      _selectedRegion.region)) {
                                    final snackBar = SnackBar(
                                      content: const Text(
                                        'ERROR! Authentication Failed',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.all(10),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    setState(() {
                                      _pageState = 0;
                                      _isNotAuthenticated = false;
                                    });
                                  }
                                }
                              },
                              child: const Button(
                                btnText: "Log In",
                                isFull: true,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class Regions {
  const Regions(this.region, this.name);

  final String name;
  final Region region;

  bool operator ==(o) => o is Regions && o.name == name && o.region == region;
}

class Button extends StatefulWidget {
  const Button({Key? key, required this.btnText, required this.isFull})
      : super(key: key);

  final String btnText;
  final bool isFull;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  Color btnColor = const Color.fromRGBO(0, 0, 0, 0);
  Color btnTextColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    if (widget.isFull) {
      btnColor = const Color(0xff14DAE2);
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
  InputWithIcon(
      {required this.icon,
      required this.hint,
      required this.controller,
      required this.obscure});

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;

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
                color: const Color(0xffbb9b9b9),
              )),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              obscureText: widget.obscure,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Required';
                }
                return null;
              },
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
