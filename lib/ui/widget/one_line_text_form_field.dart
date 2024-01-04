import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 一行の入力フォーム
class OneLineTextFormField extends StatelessWidget {
  // 入力用コントローラー
  final TextEditingController _controller;
  // 入力の可否
  final bool? _enabled;
  // ラベル
  final String? _label;
  // ヒント
  final String? _hint;
  // 入力された際の動作
  final Function(String)? _onChanged;
  // クリアされた際の動作
  final Function()? _onClear;

  /// 一行の入力フォームを生成する。
  ///
  /// [controller]に入力用のコントローラを設定する（必須）。
  /// [enabled]に入力の可否を設定する（falseの場合のみ入力できず）。
  /// [label]、[hint]にはフォームに表示されるラベルとヒントを設定する。
  /// [onChanged]は入力された際の動作を登録する。[value]には入力された文字列が渡される。
  /// [onClear]はフォームの文字列がクリアされた際の動作を登録する。
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
