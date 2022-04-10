import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_error.g.dart';

@JsonSerializable(explicitToJson: true)
class UserError extends Equatable {
  const UserError({
    required this.errorDescription,
    required this.errorCode,
    required this.error,
  });

  factory UserError.fromJson(Map<String, dynamic> json) =>
      _$UserErrorFromJson(json);

  @JsonKey(name: 'error_description')
  final String errorDescription;

  final String errorCode;
  final String error;

  Map<String, dynamic> toJson() => _$UserErrorToJson(this);

  @override
  String toString() => errorDescription;

  @override
  List<Object?> get props => [errorDescription, errorCode, error];
}
