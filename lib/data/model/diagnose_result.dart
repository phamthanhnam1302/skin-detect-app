// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagnose_result.freezed.dart';
part 'diagnose_result.g.dart';

@freezed
class DiagnoseResult with _$DiagnoseResult {
  const factory DiagnoseResult({
    @JsonKey(name: 'preds') String? title,
    @JsonKey(name: 'bot_response') String? content,
  }) = _DiagnoseResult;

  factory DiagnoseResult.fromJson(Map<String, dynamic> json) =>
      _$DiagnoseResultFromJson(json);
}
