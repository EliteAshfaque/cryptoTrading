// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChildRoles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChildRoles _$ChildRolesFromJson(Map<String, dynamic> json) => ChildRoles(
      id: (json['id'] as num?)?.toInt(),
      role: json['role'] as String?,
      ind: (json['ind'] as num?)?.toInt(),
      isActive: json['isActive'] as bool?,
      prefix: json['prefix'] as String?,
    );

Map<String, dynamic> _$ChildRolesToJson(ChildRoles instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'ind': instance.ind,
      'isActive': instance.isActive,
      'prefix': instance.prefix,
    };
