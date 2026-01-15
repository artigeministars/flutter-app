


import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Photo {
  Photo(this.id,this.photo, this.user_id, this.created_on );

  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'photo',required: true,defaultValue: '')
  String photo;
  @JsonKey(name: 'user_id')
  String user_id;
  @JsonKey(name: 'created_on')
  String created_on;
 
  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  // factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  // Map<String, dynamic> toJson() => _$UserToJson(this);
}