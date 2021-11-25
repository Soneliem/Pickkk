// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:valorant_client/valorant_client.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../vclient.dart';
import '../custom.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String IGN = "Unknown";
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

  checkAuth() async {
    setState(() {
      _isLoading = true;
    });

    if (client != null) {
      final user = await client.playerInterface.getPlayer();
      IGN = "Authenticated as: " "\n\n" + user.gameName;
    } else {
      IGN = "Not Authenticated";
    }

    setState(() {
      _isLoading = false;
    });
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
                      Column(
                        children: [
                          const Text(
                            'Status',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            IGN,
                            style: const TextStyle(
                                color: Color(0xffbc7c7c7), fontSize: 20),
                          ),
                          Button(
                              btnText: "Check Authentication",
                              onTap: checkAuth,
                              isFull: true)
                        ],
                      ),
                      Button(
                        btnText: "Log In",
                        onTap: () {
                          setState(() {
                            _pageState = 1;
                          });
                        },
                        isFull: false,
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
                          ],
                        ),
                        Button(
                          btnText: "Log In",
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
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                setState(() {
                                  _pageState = 0;
                                });
                              }
                            }
                          },
                          isFull: true,
                        ),
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
