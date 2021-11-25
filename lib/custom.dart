// Custom widgets: Button and Input

import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button(
      {Key? key,
      required this.btnText,
      required this.onTap,
      required this.isFull})
      : super(key: key);

  final String btnText;
  final Function() onTap;
  final bool isFull;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  Color btnColor = Colors.transparent;
  Color btnTextColor = Colors.white;
  Color splashColor = const Color(0xff14DAE2);

  @override
  Widget build(BuildContext context) {
    if (widget.isFull) {
      btnColor = const Color(0xff14DAE2);
      btnTextColor = Colors.black;
      splashColor = const Color(0xff251F34);
    }
    return Container(
      margin: const EdgeInsets.all(32),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff14DAE2), width: 2),
          color: btnColor,
          borderRadius: BorderRadius.circular(50)),
      child: Material(
        child: InkWell(
            splashColor: splashColor,
            highlightColor: splashColor,
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: Center(
                child: Text(
                  widget.btnText,
                  style: TextStyle(
                      color: btnTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
        color: Colors.transparent,
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
