import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_viewmodel_state.dart';

part 'warikan_calculator_viewmodel.g.dart';

/// WarikanCalculatorのビューモデル
@riverpod
class WarikanCalculatorViewModel extends _$WarikanCalculatorViewModel {
  /// 初期化処理
  @override
  WarikanCalculatorViewModelState build() {
    return const WarikanCalculatorViewModelState();
  }

  void setAmount(String amount) {
    state = state.copyWith(amount: amount);
  }

  void setTaxRate(String taxRate) {
    state = state.copyWith(taxRate: taxRate);
  }

  void setNumber(String number) {
    state = state.copyWith(number: number);
  }
  void setWithoutTax(bool withoutTax) {
    state = state.copyWith(withoutTax: withoutTax);
  }

  /// 必要なすべての項目の入力が終わっているか判定する
  bool isCalculable() {
    var result = true;

    // 金額と人数が入力されていない場合は無効
    if((state.amount == '') || (state.number == '')) {
      result = false;
    }

    // 税別価格なのに税率が入力されていない場合は無効
    if(state.withoutTax && (state.taxRate == '')) {
      result = false;
    }

    return result;
  }

  /// 割り勘金額を計算する
  void calculateAmountPerPerson({
    Function(int result)? onSuccess,
    Function()? onFailure,
  }) {
    final number = int.parse(state.number);
    if(number == 0) {
      if(onFailure != null) onFailure();
      return;
    }

    var amount = int.parse(state.amount);

    if(state.withoutTax) {
      final taxRate = int.parse(state.taxRate);
      final tax = amount * taxRate / 100;
      amount += tax.ceil();
    }

    final amountPerPerson = amount / number;

    if(onSuccess != null) onSuccess(amountPerPerson.ceil());
  }
}
