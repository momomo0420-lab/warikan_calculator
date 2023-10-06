import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warikan_calculator/ui/warikan_calculator/warikan_calculator_viewmodel_state.dart';

part 'warikan_calculator_viewmodel.g.dart';

@riverpod
class WarikanCalculatorViewModel extends _$WarikanCalculatorViewModel {
  /// 初期化処理
  @override
  WarikanCalculatorViewModelState build() {
    return WarikanCalculatorViewModelState(
      amountController: TextEditingController(),
      taxRateController: TextEditingController(),
      numberController: TextEditingController(),
      isTaxIncluded: true,
    );
  }

  /// 税率の有無を設定する
  ///
  /// [taxIncluded]を基に税率の有無を設定する
  void setTaxIncluded(bool taxIncluded) {
    state = state.copyWith(isTaxIncluded: taxIncluded);
  }
}