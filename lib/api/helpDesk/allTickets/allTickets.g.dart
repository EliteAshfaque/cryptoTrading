// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allTickets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllTicketsApiStruct _$AllTicketsApiStructFromJson(Map<String, dynamic> json) =>
    AllTicketsApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$AllTicketsApiStructToJson(
        AllTicketsApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };
