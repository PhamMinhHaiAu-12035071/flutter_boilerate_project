import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User extends Equatable {
  const User({required this.username, required this.password});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final String username;
  final String password;

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [username, password];

  static const empty = User(username: '', password: '');
}
