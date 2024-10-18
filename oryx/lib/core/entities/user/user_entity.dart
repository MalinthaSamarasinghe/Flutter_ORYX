import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.g.dart';
part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required int? id,
    required String? name,
    required String? email,
    required dynamic emailVerifiedAt,
    required DateTime? createdAt,
    required DateTime? updatedAt,
    required String? role,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, Object?> json) => _$UserEntityFromJson(json);
}
