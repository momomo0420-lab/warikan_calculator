import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OutlineTextFormField extends HookWidget {
  final bool? _enabled;
  final String? _initText;
  final String? _label;
  final String? _hint;
  final Function(String)? _onChanged;
  final Function()? _onClear;

  const OutlineTextFormField({
    super.key,
    bool? enabled,
    String? initText,
    String? label,
    String? hint,
    Function(String)? onChanged,
    Function()? onClear,
  }): _enabled = enabled,
        _initText = initText,
        _label = label,
        _hint = hint,
        _onChanged = onChanged,
        _onClear = onClear;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _initText);

    return TextFormField(
        enabled: _enabled,
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: _label,
          hintText: _hint,
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: () {
              controller.clear();
              if(_onClear != null) _onClear!();
            },
            icon: const Icon(Icons.clear),
          ),
        ),
        onChanged: _onChanged
    );
  }
}
