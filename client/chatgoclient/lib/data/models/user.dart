import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name:'id')
  String userId;
  @JsonKey(name:'email')
  String email;
  @JsonKey(name:'user_name')
  String userName;

  User({required this.email, required this.userId, required this.userName});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
