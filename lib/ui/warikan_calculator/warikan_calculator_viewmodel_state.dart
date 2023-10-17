import 'package:freezed_annotation/freezed_annotation.dart';

part 'warikan_calculator_viewmodel_state.freezed.dart';

/// [WarikanCalculatorViewModel]で使用する状態を定義する。
@freezed
class WarikanCalculatorViewModelState with _$WarikanCalculatorViewModelState {
  /// コンストラクタ
  const factory WarikanCalculatorViewModelState({
    @Default('')
    String amount,
    @Default('')
    String taxRate,
    @Default('')
    String number,
    @Default(false)
    bool withoutTax,
  }) = _WarikanCalculatorViewModelState;
}
