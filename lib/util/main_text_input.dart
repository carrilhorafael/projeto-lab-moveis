import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainTextInput extends StatelessWidget {
  final String _label;
  final String _hintText;
  final TextEditingController _controller;

  MainTextInput(this._label, this._hintText, this._controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(labelText: _label, hintText: _hintText)
          ),
        ]
      )
    );
  }
}