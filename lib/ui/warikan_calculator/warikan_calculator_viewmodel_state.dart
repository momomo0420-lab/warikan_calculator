import 'package:freezed_annotation/freezed_annotation.dart';

part 'warikan_calculator_viewmodel_state.freezed.dart';

/// [WarikanCalculatorViewModel]で使用する状態を定義する。
@freezed
class WarikanCalculatorViewModelState with _$WarikanCalculatorViewModelState {
  /// コンストラクタ
  const factory WarikanCalculatorViewModelState({
    /// 税率の有無
    /// ```
    ///   true => 税別価格
    ///   false => 税込み価格
    /// ```
    required bool isWithoutTax,
  }) = _WarikanCalculatorViewModelState;
}
