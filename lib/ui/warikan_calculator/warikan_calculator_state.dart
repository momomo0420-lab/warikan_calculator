import 'package:freezed_annotation/freezed_annotation.dart';

part 'warikan_calculator_state.freezed.dart';

/// 割り勘計算画面の状態
@freezed
class WarikanCalculatorState with _$WarikanCalculatorState {
  /// 割り勘計算画面の状態を生成する。
  ///
  /// [amount]には金額、[taxRate]には税率、[number]には人数をそれぞれ設定する。
  /// [isTaxRequired]は税率の有無を設定する（金額が税抜き価格の場合はtrue）。
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
