import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';

part 'home.state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    PermissionStatus? status,
  }) = _HomeState;
}