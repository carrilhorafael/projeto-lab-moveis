import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainDropdown extends StatefulWidget {
  final List<DropdownMenuItem<String>> _items;
  final String _hint;
  final String _label;

  MainDropdown(this._items, this._hint, this._label);

  @override
  _MainDropdownState createState() {
    return _MainDropdownState();
  }
}

class _MainDropdownState extends State<MainDropdown> {
  String? _value;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(widget._label),
        DropdownButton<String>(
          items: widget._items,
          onChanged: (String? value) {
            setState(() {
              _value = value;
            });
          },
          hint: Text(widget._hint),
          value: _value,
        ),
      ],
    ));
  }
}
