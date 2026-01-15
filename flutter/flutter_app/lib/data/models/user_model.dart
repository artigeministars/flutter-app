import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  User(this.id,this.username, this.password, this.email );

  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'username',required: true,defaultValue: false)
  String username;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'password')
  String password;
 
}
