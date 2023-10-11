import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_viewmodel.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_viewmodel_state.dart';

class WarikanCalculatorBody extends StatelessWidget {
  final WarikanCalculatorViewModel _viewModel;
  final WarikanCalculatorViewModelState _state;

  const WarikanCalculatorBody({
    required WarikanCalculatorViewModel viewModel,
    required WarikanCalculatorViewModelState state,
    super.key,
  }): _viewModel = viewModel,
    _state = state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 金額入力フォーム
            _buildTextFormField(
              true,
              _state.amountController,
              '金額',
              '円',
              () => _viewModel.clearAmountController(),
            ),
            const SizedBox(height: 16.0),

            // 税込み、税別の切り替えスイッチ
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('金額は税別価格ですか？'),
                Switch(
                  value: _state.isWithoutTax,
                  onChanged: (isWithoutTax) => _viewModel.setWithoutTax(isWithoutTax),
                  activeColor: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // 税率入力フォーム
            _buildTextFormField(
              _state.isWithoutTax,
              _state.taxRateController,
              '税率',
              '％',
              () => _viewModel.clearTaxRateController(),
            ),
            const SizedBox(height: 16.0),

            // 人数入力フォーム
            _buildTextFormField(
              true,
              _state.numberController,
              '人数',
              '人',
              () => _viewModel.clearNumberController(),
            ),
            const SizedBox(height: 32.0),

            ElevatedButton(
              onPressed: () => _viewModel.calculateAmountPerPerson(
                (result) => _showResultDialog(context, result),
                (message) => _showFailureSnackBar(context, message),
              ),
              child: const Text('計算する'),
            )
          ],
        ),
      ),
    );
  }

  TextFormField _buildTextFormField(
    // 表示の有無
    bool enabled,
    // コントローラー
    TextEditingController controller,
    // ラベル
    String label,
    // 単位
    String unit,
    // クリアされた際の動き
    Function()? onClear
  ) {
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
          onPressed: () => (onClear != null) ? onClear() : null,
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
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }
}
