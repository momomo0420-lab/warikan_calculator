import 'package:flutter/material.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_state.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_view_model.dart';
import 'package:warikan_calculator/ui/widget/labeled_switch.dart';
import 'package:warikan_calculator/ui/widget/one_line_text_form_field.dart';

class WarikanCalculatorBody extends StatefulWidget {
  final WarikanCalculatorViewModel _viewModel;
  final WarikanCalculatorState _state;

  const WarikanCalculatorBody({
    super.key,
    required WarikanCalculatorViewModel viewModel,
    required WarikanCalculatorState state,
  }): _viewModel = viewModel,
        _state = state;

  @override
  State<WarikanCalculatorBody> createState() => _WarikanCalculatorBodyState();
}

class _WarikanCalculatorBodyState extends State<WarikanCalculatorBody> {
  late final TextEditingController _amountController;
  late final TextEditingController _taxRateController;
  late final TextEditingController _numberController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _taxRateController = TextEditingController();
    _numberController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _taxRateController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = widget._viewModel;
    final state = widget._state;

    return Column(
      children: [
        // 金額入力フォーム
        OneLineTextFormField(
          controller: _amountController,
          label: '金額(円)',
          hint: '金額を入力してください。',
          onChanged: (amount) => viewModel.setAmount(amount),
          onClear: () => viewModel.clearAmount(),
        ),
        const SizedBox(height: 16.0),

        // 税込み、税別の切り替えスイッチ
        LabeledSwitch(
          label: '金額は税別価格ですか？',
          value: state.isTaxRequired,
          onChanged: (_) => viewModel.toggleTax(),
        ),
        const SizedBox(height: 16.0),

        // 税率入力フォーム
        OneLineTextFormField(
          controller: _taxRateController,
          enabled: state.isTaxRequired,
          label: '税率(％)',
          hint: '税率を入力してください。',
          onChanged: (taxRate) => viewModel.setTaxRate(taxRate),
          onClear: () => viewModel.clearTaxRate(),
        ),
        const SizedBox(height: 16.0),

        // 人数入力フォーム
        OneLineTextFormField(
          controller: _numberController,
          label: '人数(人)',
          hint: '人数を入力してください。',
          onChanged: (number) => viewModel.setNumber(number),
          onClear: () => viewModel.clearNumber(),
        ),
        const SizedBox(height: 32.0),

        ElevatedButton(
          onPressed: !viewModel.isCalculable() ? null :
            () => viewModel.calculateAmountPerPerson(
              onSuccess: (result) => _showResultDialog(context, result),
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
}
