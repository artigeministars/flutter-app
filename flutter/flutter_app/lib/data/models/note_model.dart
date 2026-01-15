
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Note {
  Note(this.id,this.headerValue,this.expandedValue,this.user_id,this.created_on,this.isExpanded);

  @JsonKey(name:"id")
  String id;
  @JsonKey(name:"headerValue")
  String headerValue;
  @JsonKey(name:"expandedValue")
  String expandedValue;
  @JsonKey(name:"user_id")
  String user_id;
  @JsonKey(name:"created_on")
  String created_on;
  @JsonKey(name:"isExpanded",required: false,defaultValue: false)
  bool isExpanded;

}