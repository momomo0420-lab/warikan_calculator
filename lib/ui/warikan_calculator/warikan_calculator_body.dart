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

    final amountController = useTextEditingController(text: '');
    final taxRateController = useTextEditingController(text: '');
    final numberController = useTextEditingController(text: '');

    return SingleChildScrollView(
      child: Column(
        children: [
          // 金額入力フォーム
          _buildTextFormField(
            enabled: true,
            controller: amountController,
            label: '金額',
            unit: '円',
            onChanged: (amount) => viewModel.setAmount(amount),
            onClear: () => viewModel.setAmount(''),
          ),
          const SizedBox(height: 16.0),

          // 税込み、税別の切り替えスイッチ
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('金額は税別価格ですか？'),
              Switch(
                value: state.withoutTax,
                onChanged: (withoutTax) => viewModel.setWithoutTax(withoutTax),
                activeColor: Colors.blue,
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // 税率入力フォーム
          _buildTextFormField(
            enabled: state.withoutTax,
            controller: taxRateController,
            label: '税率',
            unit: '％',
            onChanged: (taxRate) => viewModel.setTaxRate(taxRate),
            onClear: () => viewModel.setTaxRate(''),
          ),
          const SizedBox(height: 16.0),

          // 人数入力フォーム
          _buildTextFormField(
            enabled: true,
            controller: numberController,
            label: '人数',
            unit: '人',
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
      ),
    );
  }

  TextFormField _buildTextFormField({
    required bool enabled,
    required TextEditingController controller,
    required String label,
    required String unit,
    Function(String)? onChanged,
    Function()? onClear,
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
          onPressed: () {
            controller.clear();
            if(onClear != null) onClear();
          },
          icon: const Icon(Icons.clear),
        ),
      ),
      onChanged: (value) {
        if(onChanged != null) onChanged(value);
      }
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
