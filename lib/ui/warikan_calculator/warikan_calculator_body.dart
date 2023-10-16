import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_viewmodel.dart';

class WarikanCalculatorBody extends HookConsumerWidget {
  const WarikanCalculatorBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(warikanCalculatorViewModelProvider.notifier);
    final state = ref.watch(warikanCalculatorViewModelProvider);

    final amountController = useTextEditingController(text: "");
    final taxRateController = useTextEditingController(text: "");
    final numberController = useTextEditingController(text: "");

    return SingleChildScrollView(
      child: Column(
        children: [
          // 金額入力フォーム
          _buildTextFormField(
            enabled: true,
            controller: amountController,
            label: '金額',
            unit: '円',
          ),
          const SizedBox(height: 16.0),

          // 税込み、税別の切り替えスイッチ
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('金額は税別価格ですか？'),
              Switch(
                value: state.isWithoutTax,
                onChanged: (isWithoutTax) => viewModel.setWithoutTax(isWithoutTax),
                activeColor: Colors.blue,
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // 税率入力フォーム
          _buildTextFormField(
            enabled: state.isWithoutTax,
            controller: taxRateController,
            label: '税率',
            unit: '％',
          ),
          const SizedBox(height: 16.0),

          // 人数入力フォーム
          _buildTextFormField(
            enabled: true,
            controller: numberController,
            label: '人数',
            unit: '人',
          ),
          const SizedBox(height: 32.0),

          ElevatedButton(
            onPressed: () => viewModel.calculateAmountPerPerson(
              amountText: amountController.text,
              taxRateText: taxRateController.text,
              numberText: numberController.text,
              onSuccess: (result) => _showResultDialog(context, result),
              onFailure: (error) => _showFailureSnackBar(context, error),
            ),
            child: const Text('計算する'),
          )
        ],
      ),
    );
  }

  TextFormField _buildTextFormField({
    required bool enabled,
    required TextEditingController controller,
    required String label,
    required String unit,
  }) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: '$label（$unit）',
        hintText: '$labelを入力してください。',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: () => controller.clear(),
          icon: const Icon(Icons.clear),
        ),
      ),
    );
  }

  void _showResultDialog(
    BuildContext context,
    double result,
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
    CalculationError error,
  ) {
    String message = '';

    switch(error) {
      case CalculationError.divisionByZero:
        message = '人数０人は入力できません。';
        break;
      case CalculationError.notEntered:
        message = '未入力の項目があります。';
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }
}
