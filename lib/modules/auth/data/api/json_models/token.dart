import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(explicitToJson: true)
class Token extends Equatable {
  const Token({
    required this.id,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.tokenType,
  });

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  @HiveField(0)
  final String id;

  @HiveField(1)
  @JsonKey(name: 'access_token')
  final String accessToken;

  @HiveField(2)
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  @HiveField(3)
  @JsonKey(name: 'expires_in')
  final int expiresIn;

  @HiveField(4)
  @JsonKey(name: 'token_type')
  final String tokenType;

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  @override
  List<Object?> get props => [id];
}
