import 'package:flutter/material.dart';

class LabeledSwitch extends StatelessWidget {
  final String _label;
  final bool _value;
  final Function(bool)? _onChanged;

  const LabeledSwitch({
    super.key,
    required String label,
    required bool value,
    Function(bool value)? onChanged,
  }): _label = label,
        _value = value,
        _onChanged = onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(_label),
        Switch(
          value: _value,
          onChanged: _onChanged,
          activeColor: Colors.blue,
        ),
      ],
    );
  }
}
