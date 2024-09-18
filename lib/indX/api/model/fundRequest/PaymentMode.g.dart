// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PaymentMode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMode _$PaymentModeFromJson(Map<String, dynamic> json) => PaymentMode(
      id: (json['id'] as num?)?.toInt(),
      bankID: (json['bankID'] as num?)?.toInt(),
      modeID: (json['modeID'] as num?)?.toInt(),
      isActive: json['isActive'] as bool?,
      mode: json['mode'] as String?,
      isTransactionIdAuto: json['isTransactionIdAuto'] as bool?,
      isAccountHolderRequired: json['isAccountHolderRequired'] as bool?,
      isChequeNoRequired: json['isChequeNoRequired'] as bool?,
      isCardNumberRequired: json['isCardNumberRequired'] as bool?,
      isMobileNoRequired: json['isMobileNoRequired'] as bool?,
      isBranchRequired: json['isBranchRequired'] as bool?,
      isUPIID: json['isUPIID'] as bool?,
      cid: json['cid'] as String?,
    );

Map<String, dynamic> _$PaymentModeToJson(PaymentMode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bankID': instance.bankID,
      'modeID': instance.modeID,
      'isActive': instance.isActive,
      'mode': instance.mode,
      'isTransactionIdAuto': instance.isTransactionIdAuto,
      'isAccountHolderRequired': instance.isAccountHolderRequired,
      'isChequeNoRequired': instance.isChequeNoRequired,
      'isCardNumberRequired': instance.isCardNumberRequired,
      'isMobileNoRequired': instance.isMobileNoRequired,
      'isBranchRequired': instance.isBranchRequired,
      'isUPIID': instance.isUPIID,
      'cid': instance.cid,
    };
