import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:health/data/model/diagnose_result.dart';

part 'result.state.freezed.dart';

@freezed
class ResultState with _$ResultState {
  const factory ResultState({
    @Default(1) int status,
    DiagnoseResult? result,
    @Default('') String error,
  }) = _ResultState;
}
