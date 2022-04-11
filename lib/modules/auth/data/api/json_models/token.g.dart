// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenAdapter extends TypeAdapter<Token> {
  @override
  final int typeId = 0;

  @override
  Token read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Token(
      id: fields[0] as String,
      accessToken: fields[1] as String,
      refreshToken: fields[2] as String,
      expiresIn: fields[3] as int,
      tokenType: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Token obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.accessToken)
      ..writeByte(2)
      ..write(obj.refreshToken)
      ..writeByte(3)
      ..write(obj.expiresIn)
      ..writeByte(4)
      ..write(obj.tokenType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      id: json['id'] as String,
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresIn: json['expires_in'] as int,
      tokenType: json['token_type'] as String,
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'id': instance.id,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expires_in': instance.expiresIn,
      'token_type': instance.tokenType,
    };
