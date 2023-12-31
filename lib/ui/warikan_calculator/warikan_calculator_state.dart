import 'package:freezed_annotation/freezed_annotation.dart';

part 'warikan_calculator_state.freezed.dart';

/// [WarikanCalculatorViewModel]で使用する状態を定義する。
@freezed
class WarikanCalculatorState with _$WarikanCalculatorState {
  /// コンストラクタ
  const factory WarikanCalculatorState({
    @Default('')
    String amount,
    @Default('')
    String taxRate,
    @Default('')
    String number,
    @Default(false)
    bool isTaxRequired,
  }) = _WarikanCalculatorState;
}
