import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_state.dart';

part 'warikan_calculator_view_model.g.dart';

/// WarikanCalculatorのビューモデル
@riverpod
class WarikanCalculatorViewModel extends _$WarikanCalculatorViewModel {
  /// 初期化処理
  @override
  WarikanCalculatorState build() {
    return const WarikanCalculatorState();
  }

  void setAmount(String amount) {
    state = state.copyWith(amount: amount);
  }

  void clearAmount() {
    setAmount('');
  }

  void setTaxRate(String taxRate) {
    state = state.copyWith(taxRate: taxRate);
  }

  void clearTaxRate() {
    setTaxRate('');
  }

  void setNumber(String number) {
    state = state.copyWith(number: number);
  }

  void clearNumber() {
    setNumber('');
  }

  void toggleTax() {
    final isTaxRequired = state.isTaxRequired;
    state = state.copyWith(isTaxRequired: !isTaxRequired);
  }

  /// 必要なすべての項目の入力が終わっているか判定する
  bool isCalculable() {
    // 金額と人数が入力されていない場合は無効
    if((state.amount == '') || (state.number == '')) {
      return false;
    }

    // 人数に０が設定されている場合
    final number = int.parse(state.number);
    if(number == 0) {
      return false;
    }

    // 税別価格なのに税率が入力されていない場合は無効
    if(state.isTaxRequired && (state.taxRate == '')) {
      return false;
    }

    return true;
  }

  /// 割り勘金額を計算する
  void calculateAmountPerPerson({
    Function(int result)? onSuccess,
  }) {
    var amount = int.parse(state.amount);

    if(state.isTaxRequired) {
      final taxRate = int.parse(state.taxRate);
      final tax = amount * taxRate / 100;
      amount += tax.ceil();
    }

    final number = int.parse(state.number);
    final amountPerPerson = amount / number;

    if(onSuccess != null) onSuccess(amountPerPerson.ceil());
  }
}
