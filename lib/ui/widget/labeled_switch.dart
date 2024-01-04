import 'package:flutter/material.dart';

/// ラベルスイッチ
class LabeledSwitch extends StatelessWidget {
  // ラベル
  final String _label;
  // スイッチの状態
  final bool _value;
  // スイッチが変更された際の動作
  final Function(bool)? _onChanged;

  /// ラベルスイッチを生成する。
  ///
  /// [label]に表示されるラベルを設定する。
  /// [value]にスイッチの状態を設定する（true - ON, false - OFF）。
  /// [onChange]にスイッチが変更されたいの動作を設定する。
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
