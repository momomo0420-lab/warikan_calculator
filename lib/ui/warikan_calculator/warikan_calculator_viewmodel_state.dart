import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'warikan_calculator_viewmodel_state.freezed.dart';

/// [WarikanCalculatorViewModel]で使用する状態を定義する。
@freezed
class WarikanCalculatorViewModelState with _$WarikanCalculatorViewModelState {
  /// コンストラクタ
  const factory WarikanCalculatorViewModelState({
    /// 金額入力用のコントローラー
    required TextEditingController amountController,
    /// 税率入力用のコントローラー
    required TextEditingController taxRateController,
    /// 人数入力用のコントローラー
    required TextEditingController numberController,
    /// 税率の有無
    /// ```
    ///   true => 税込み価格
    ///   false => 税別価格
    /// ```
    required bool isTaxIncluded,
  }) = _WarikanCalculatorViewModelState;
}
