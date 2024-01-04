import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_state.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_view_model.dart';
import 'package:warikan_calculator/ui/widget/labeled_switch.dart';
import 'package:warikan_calculator/ui/widget/one_line_text_form_field.dart';

/// 割り勘計算画面の本体
class WarikanCalculatorBody extends HookWidget {
  // ビューモデル
  final WarikanCalculatorViewModel _viewModel;
  // 状態
  final WarikanCalculatorState _state;

  /// 割り勘計算画面の本体を作成する。
  ///
  /// [viewModel]と[state]を使用し、表示させる内容やボタン押下時の処理などを決定する。
  const WarikanCalculatorBody({
    super.key,
    required WarikanCalculatorViewModel viewModel,
    required WarikanCalculatorState state,
  }): _viewModel = viewModel,
        _state = state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 金額入力フォーム
        OneLineTextFormField(
          controller: useTextEditingController(),
          label: '金額(円)',
          hint: '金額を入力してください。',
          onChanged: (amount) => _viewModel.setAmount(amount),
          onClear: () => _viewModel.clearAmount(),
        ),
        const SizedBox(height: 16.0),

        // 税込み、税別の切り替えスイッチ
        LabeledSwitch(
          label: '金額は税別価格ですか？',
          value: _state.isTaxRequired,
          onChanged: (_) => _viewModel.toggleTax(),
        ),
        const SizedBox(height: 16.0),

        // 税率入力フォーム
        OneLineTextFormField(
          controller: useTextEditingController(),
          enabled: _state.isTaxRequired,
          label: '税率(％)',
          hint: '税率を入力してください。',
          onChanged: (taxRate) => _viewModel.setTaxRate(taxRate),
          onClear: () => _viewModel.clearTaxRate(),
        ),
        const SizedBox(height: 16.0),

        // 人数入力フォーム
        OneLineTextFormField(
          controller: useTextEditingController(),
          label: '人数(人)',
          hint: '人数を入力してください。',
          onChanged: (number) => _viewModel.setNumber(number),
          onClear: () => _viewModel.clearNumber(),
        ),
        const SizedBox(height: 32.0),

        ElevatedButton(
          onPressed: !_viewModel.isCalculable() ? null :
            () => _viewModel.calculateAmountPerPerson(
              onSuccess: (result) => _showResultDialog(context, result),
            ),
          child: const Text('計算する'),
        )
      ],
    );
  }

  /// 計算結果表示するダイアログを作成する。
  void _showResultDialog(
    BuildContext context,
    int result,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('計算結果'),
        content: Text('一人当たりの金額は $result 円です。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }
}
