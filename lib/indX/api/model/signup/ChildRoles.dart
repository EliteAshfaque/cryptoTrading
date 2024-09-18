import 'package:json_annotation/json_annotation.dart';
part 'ChildRoles.g.dart';
@JsonSerializable()
class ChildRoles {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "role")
  String? role;
  @JsonKey(name: "ind")
  int? ind;
  @JsonKey(name: "isActive")
  bool? isActive;
  @JsonKey(name: "prefix")
  String? prefix;


  ChildRoles({this.id, this.role, this.ind, this.isActive, this.prefix});

  factory ChildRoles.fromJson(Map<String, dynamic> json) =>
      _$ChildRolesFromJson(json);

  Map<String, dynamic> toJson() => _$ChildRolesToJson(this);
}
