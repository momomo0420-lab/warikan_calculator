import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_state.dart';

part 'warikan_calculator_view_model.g.dart';

/// 割り勘計算画面のビューモデル
@riverpod
class WarikanCalculatorViewModel extends _$WarikanCalculatorViewModel {
  @override
  WarikanCalculatorState build() {
    return const WarikanCalculatorState();
  }

  /// 金額（状態）を設定する。
  ///
  /// [amount]で金額（状態）を更新する。
  void setAmount(String amount) {
    state = state.copyWith(amount: amount);
  }

  /// 金額（状態）を初期化する。
  void clearAmount() {
    setAmount('');
  }

  /// 税率（状態）を設定する。
  ///
  /// [taxRate]で税率（状態）を更新する。
  void setTaxRate(String taxRate) {
    state = state.copyWith(taxRate: taxRate);
  }

  /// 税率（状態）を設定する。
  void clearTaxRate() {
    setTaxRate('');
  }

  /// 人数（状態）を設定する。
  ///
  /// [number]で人数（状態）を更新する。
  void setNumber(String number) {
    state = state.copyWith(number: number);
  }

  /// 人数（状態）を初期化する。
  void clearNumber() {
    setNumber('');
  }

  /// 税金の有無を切り替える。
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

    // 税金を計算する
    if(state.isTaxRequired) {
      final taxRate = int.parse(state.taxRate);
      final tax = amount * taxRate / 100;
      amount += tax.ceil();
    }

    // 一人当たりの金額を計算する
    final number = int.parse(state.number);
    final amountPerPerson = amount / number;

    // 一人当たりの金額を返却する
    if(onSuccess != null) onSuccess(amountPerPerson.ceil());
  }
}
