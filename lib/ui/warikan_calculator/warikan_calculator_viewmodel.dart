import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_viewmodel_state.dart';

part 'warikan_calculator_viewmodel.g.dart';

/// WarikanCalculatorのビューモデル
@riverpod
class WarikanCalculatorViewModel extends _$WarikanCalculatorViewModel {
  /// 初期化処理
  @override
  WarikanCalculatorViewModelState build() {
    return const WarikanCalculatorViewModelState(
      isWithoutTax: false,
    );
  }

  /// 税率の有無を設定する
  ///
  /// [isWithoutTax]を基に税率の有無を設定する
  void setWithoutTax(bool isWithoutTax) {
    state = state.copyWith(isWithoutTax: isWithoutTax);
  }

  /// 必要なすべての項目の入力が終わっているか判定する
  bool _checkAllFieldEntered(
    String amountText,
    String taxRateText,
    String numberText,
  ) {
    var result = true;

    // 金額と人数が入力されていない場合は無効
    if((amountText == "") || (numberText == "")) {
      result = false;
    }

    // 税別価格なのに税率が入力されていない場合は無効
    if(state.isWithoutTax && (taxRateText == "")) {
      result = false;
    }

    return result;
  }

  /// 割り勘金額を計算する
  void calculateAmountPerPerson({
    required String amountText,
    required String taxRateText,
    required String numberText,
    Function(double result)? onSuccess,
    Function(CalculationError error)? onFailure,
  }) {
    if(!_checkAllFieldEntered(amountText, taxRateText, numberText)) {
      if(onFailure != null) onFailure(CalculationError.notEntered);
      return;
    }

    final number = int.parse(numberText);
    if(number == 0) {
      if(onFailure != null) onFailure(CalculationError.divisionByZero);
      return;
    }

    var amount = int.parse(amountText);

    if(state.isWithoutTax) {
      final taxRate = int.parse(taxRateText);
      final tax = amount * taxRate ~/ 100;
      amount += tax;
    }

    if(onSuccess != null) onSuccess(amount / number);
  }
}

enum CalculationError {
  notEntered(1),
  divisionByZero(2);

  final int id;

  const CalculationError(this.id);
}