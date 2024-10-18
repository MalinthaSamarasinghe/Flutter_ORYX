import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../../../core/entities/user/login_entity.dart';
import '../../../../core/entities/user/user_entity.dart';

LoginModel loginFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel extends Equatable {
  final String? message;
  final UserModel? user;
  final String? token;

  const LoginModel({
    this.message,
    this.user,
    this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json["message"],
      user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "user": user?.toJson(),
      "token": token,
    };
  }

  @override
  List<Object?> get props => [message, user, token];

  LoginEntity toEntity() {
    return LoginEntity(
      message: message,
      user: UserEntity(
        id: user?.id,
        name: user?.name,
        email: user?.email,
        emailVerifiedAt: user?.emailVerifiedAt,
        createdAt: user?.createdAt,
        updatedAt: user?.updatedAt,
        role: user?.role,
      ),
      token: token,
    );
  }
}

class UserModel extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? role;

  const UserModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "role": role,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        emailVerifiedAt,
        createdAt,
        updatedAt,
        role,
      ];
}
