import 'user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_entity.g.dart';
part 'login_entity.freezed.dart';

@freezed
class LoginEntity with _$LoginEntity {
  const factory LoginEntity({
    required String? message,
    required UserEntity? user,
    required String? token,
  }) = _LoginEntity;

  factory LoginEntity.fromJson(Map<String, Object?> json) => _$LoginEntityFromJson(json);
}
