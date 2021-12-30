import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_lab/domain/entities/location/state.dart' as Location;

class MainDropdown extends StatelessWidget {
  final List<DropdownMenuItem<Location.State>> _items;
  final String _hint;
  final String _label;
  final void Function(Location.State?) onChanged;

  MainDropdown(this._items, this._hint, this._label, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(_label),
        DropdownButtonFormField<Location.State>(
          items: _items,
          onChanged: onChanged,
          hint: Text(_hint),
        ),
      ],
    ));
  }
}
