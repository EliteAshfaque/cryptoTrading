// GENERATED CODE - DO NOT MODIFY BY HAND

part of '24HourVolume.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Last24HourVolumeApiStruct _$Last24HourVolumeApiStructFromJson(
        Map<String, dynamic> json) =>
    Last24HourVolumeApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$Last24HourVolumeApiStructToJson(
        Last24HourVolumeApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
