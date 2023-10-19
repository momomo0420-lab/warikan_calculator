import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_viewmodel.dart';
import 'package:warikan_calculator/ui/widget/outline_text_form_field.dart';
import 'package:warikan_calculator/ui/widget/labeled_switch.dart';

class WarikanCalculatorBody extends ConsumerWidget {
  const WarikanCalculatorBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(warikanCalculatorViewModelProvider.notifier);
    final state = ref.watch(warikanCalculatorViewModelProvider);

    return Column(
      children: [
        // 金額入力フォーム
        OutlineTextFormField(
          label: '金額(円)',
          hint: '金額を入力してください。',
          onChanged: (amount) => viewModel.setAmount(amount),
          onClear: () => viewModel.setAmount(''),
        ),
        const SizedBox(height: 16.0),

        // 税込み、税別の切り替えスイッチ
        LabeledSwitch(
          label: '金額は税別価格ですか？',
          value: state.withoutTax,
          onChanged: (withoutTax) => viewModel.setWithoutTax(withoutTax),
        ),
        const SizedBox(height: 16.0),

        // 税率入力フォーム
        OutlineTextFormField(
          enabled: state.withoutTax,
          label: '税率(％)',
          hint: '税率を入力してください。',
          onChanged: (taxRate) => viewModel.setTaxRate(taxRate),
          onClear: () => viewModel.setTaxRate(''),
        ),
        const SizedBox(height: 16.0),

        // 人数入力フォーム
        OutlineTextFormField(
          label: '人数(人)',
          hint: '人数を入力してください。',
          onChanged: (number) => viewModel.setNumber(number),
          onClear: () => viewModel.setNumber(''),
        ),
        const SizedBox(height: 32.0),

        ElevatedButton(
          onPressed: !viewModel.isCalculable() ? null :
            () => viewModel.calculateAmountPerPerson(
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
