// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
      userID: (json['userID'] as num?)?.toInt(),
      name: json['name'] as String?,
      mobileNo: json['mobileNo'] as String?,
      sessionID: (json['sessionID'] as num?)?.toInt(),
      roleName: json['roleName'] as String?,
      roleID: (json['roleID'] as num?)?.toInt(),
      slabID: (json['slabID'] as num?)?.toInt(),
      loginTypeID: (json['loginTypeID'] as num?)?.toInt(),
      emailID: json['emailID'] as String?,
      session: json['session'] as String?,
      outletID: (json['outletID'] as num?)?.toInt(),
      isDoubleFactor: json['isDoubleFactor'] as bool?,
      isPinRequired: json['isPinRequired'] as bool?,
      isRealAPI: json['isRealAPI'] as bool?,
      isDebitAllowed: json['isDebitAllowed'] as bool?,
      stateID: (json['stateID'] as num?)?.toInt(),
      state: json['state'] as String?,
      pincode: json['pincode'] as String?,
      wid: (json['wid'] as num?)?.toInt(),
      accountSecretKey: json['accountSecretKey'] as String?,
      isEmailVerified: json['isEmailVerified'] as bool?,
      prefix: json['prefix'] as String?,
    );

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'userID': instance.userID,
      'name': instance.name,
      'mobileNo': instance.mobileNo,
      'sessionID': instance.sessionID,
      'roleName': instance.roleName,
      'roleID': instance.roleID,
      'slabID': instance.slabID,
      'loginTypeID': instance.loginTypeID,
      'emailID': instance.emailID,
      'session': instance.session,
      'outletID': instance.outletID,
      'isDoubleFactor': instance.isDoubleFactor,
      'isPinRequired': instance.isPinRequired,
      'isRealAPI': instance.isRealAPI,
      'isDebitAllowed': instance.isDebitAllowed,
      'stateID': instance.stateID,
      'state': instance.state,
      'pincode': instance.pincode,
      'wid': instance.wid,
      'accountSecretKey': instance.accountSecretKey,
      'isEmailVerified': instance.isEmailVerified,
      'prefix': instance.prefix,
    };
