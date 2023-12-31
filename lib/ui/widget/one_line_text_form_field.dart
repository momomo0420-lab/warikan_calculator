import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OneLineTextFormField extends StatelessWidget {
  final TextEditingController _controller;
  final bool? _enabled;
  final String? _label;
  final String? _hint;
  final Function(String)? _onChanged;
  final Function()? _onClear;

  const OneLineTextFormField({
    super.key,
    required TextEditingController controller,
    bool? enabled,
    String? label,
    String? hint,
    Function(String)? onChanged,
    Function()? onClear,
  }): _controller = controller,
        _enabled = enabled,
        _label = label,
        _hint = hint,
        _onChanged = onChanged,
        _onClear = onClear;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: _enabled,
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: _label,
        hintText: _hint,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () {
            _controller.clear();
            if(_onClear != null) _onClear!();
          },
          icon: const Icon(Icons.clear),
        ),
      ),
      onChanged: _onChanged,
    );
  }
}
