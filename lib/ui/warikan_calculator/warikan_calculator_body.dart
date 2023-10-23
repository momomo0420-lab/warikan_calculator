import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_viewmodel.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_viewmodel_state.dart';
import 'package:warikan_calculator/ui/widget/labeled_switch.dart';
import 'package:warikan_calculator/ui/widget/one_line_text_form_field.dart';

class WarikanCalculatorBody extends HookWidget {
  final WarikanCalculatorViewModel _viewModel;
  final WarikanCalculatorViewModelState _state;

  const WarikanCalculatorBody({
    super.key,
    required WarikanCalculatorViewModel viewModel,
    required WarikanCalculatorViewModelState state,
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
          onClear: () => _viewModel.setAmount(''),
        ),
        const SizedBox(height: 16.0),

        // 税込み、税別の切り替えスイッチ
        LabeledSwitch(
          label: '金額は税別価格ですか？',
          value: _state.withoutTax,
          onChanged: (withoutTax) => _viewModel.setWithoutTax(withoutTax),
        ),
        const SizedBox(height: 16.0),

        // 税率入力フォーム
        OneLineTextFormField(
          controller: useTextEditingController(),
          enabled: _state.withoutTax,
          label: '税率(％)',
          hint: '税率を入力してください。',
          onChanged: (taxRate) => _viewModel.setTaxRate(taxRate),
          onClear: () => _viewModel.setTaxRate(''),
        ),
        const SizedBox(height: 16.0),

        // 人数入力フォーム
        OneLineTextFormField(
          controller: useTextEditingController(),
          label: '人数(人)',
          hint: '人数を入力してください。',
          onChanged: (number) => _viewModel.setNumber(number),
          onClear: () => _viewModel.setNumber(''),
        ),
        const SizedBox(height: 32.0),

        ElevatedButton(
          onPressed: !_viewModel.isCalculable() ? null :
            () => _viewModel.calculateAmountPerPerson(
              onSuccess: (result) => _showResultDialog(context, result),
              onFailure: () => _showFailureSnackBar(context),
            ),
          child: const Text('計算する'),
        )
      ],
    );
  }

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

  void _showFailureSnackBar(
    BuildContext context,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('人数０人は入力できません。'))
    );
  }
}
