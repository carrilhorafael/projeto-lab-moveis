import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: Color(0xFF4CAF50),
        fixedSize: Size(262, 40),
        textStyle: TextStyle(
            fontFamily: 'Nunito', fontWeight: FontWeight.bold, fontSize: 18));
    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: Text(text),
    );
  }
}
