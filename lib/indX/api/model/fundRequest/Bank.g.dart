// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bank _$BankFromJson(Map<String, dynamic> json) => Bank(
      bankName: json['bankName'] as String?,
      logo: json['logo'] as String?,
      bankQRLogo: json['bankQRLogo'] as String?,
      cid: json['cid'] as String?,
      entryBy: (json['entryBy'] as num?)?.toInt(),
      lt: (json['lt'] as num?)?.toInt(),
      bankMasters: json['bankMasters'] as String?,
      qrPath: json['qrPath'] as String?,
      preStatusofQR: (json['preStatusofQR'] as num?)?.toInt(),
      mode: (json['mode'] as List<dynamic>?)
          ?.map((e) => PaymentMode.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: (json['id'] as num?)?.toInt(),
      branchName: json['branchName'] as String?,
      accountHolder: json['accountHolder'] as String?,
      accountNo: json['accountNo'] as String?,
      isqrenable: json['isqrenable'] as bool?,
      neftStatus: json['neftStatus'] as bool?,
      neftID: (json['neftID'] as num?)?.toInt(),
      rtgsStatus: json['rtgsStatus'] as bool?,
      rtgsid: (json['rtgsid'] as num?)?.toInt(),
      impsStatus: json['impsStatus'] as bool?,
      impsid: (json['impsid'] as num?)?.toInt(),
      thirdPartyTransferStatus: json['thirdPartyTransferStatus'] as bool?,
      thirdPartyTransferID: (json['thirdPartyTransferID'] as num?)?.toInt(),
      cashDepositStatus: json['cashDepositStatus'] as bool?,
      cashDepositID: (json['cashDepositID'] as num?)?.toInt(),
      gccStatus: json['gccStatus'] as bool?,
      gccid: (json['gccid'] as num?)?.toInt(),
      chequeStatus: json['chequeStatus'] as bool?,
      chequeID: (json['chequeID'] as num?)?.toInt(),
      scanPayStatus: json['scanPayStatus'] as bool?,
      scanPayID: (json['scanPayID'] as num?)?.toInt(),
      upiStatus: json['upiStatus'] as bool?,
      upiid: (json['upiid'] as num?)?.toInt(),
      exchangeStatus: json['exchangeStatus'] as bool?,
      exchangeID: (json['exchangeID'] as num?)?.toInt(),
      ifscCode: json['ifscCode'] as String?,
      charge: (json['charge'] as num?)?.toDouble(),
      rImageUrl: json['rImageUrl'] as String?,
      isbankLogoAvailable: json['isbankLogoAvailable'] as bool?,
      upinumber: json['upinUmber'] as String?,
    );

Map<String, dynamic> _$BankToJson(Bank instance) => <String, dynamic>{
      'bankName': instance.bankName,
      'logo': instance.logo,
      'bankQRLogo': instance.bankQRLogo,
      'cid': instance.cid,
      'entryBy': instance.entryBy,
      'lt': instance.lt,
      'bankMasters': instance.bankMasters,
      'qrPath': instance.qrPath,
      'preStatusofQR': instance.preStatusofQR,
      'mode': instance.mode,
      'id': instance.id,
      'branchName': instance.branchName,
      'accountHolder': instance.accountHolder,
      'accountNo': instance.accountNo,
      'isqrenable': instance.isqrenable,
      'neftStatus': instance.neftStatus,
      'neftID': instance.neftID,
      'rtgsStatus': instance.rtgsStatus,
      'rtgsid': instance.rtgsid,
      'impsStatus': instance.impsStatus,
      'impsid': instance.impsid,
      'thirdPartyTransferStatus': instance.thirdPartyTransferStatus,
      'thirdPartyTransferID': instance.thirdPartyTransferID,
      'cashDepositStatus': instance.cashDepositStatus,
      'cashDepositID': instance.cashDepositID,
      'gccStatus': instance.gccStatus,
      'gccid': instance.gccid,
      'chequeStatus': instance.chequeStatus,
      'chequeID': instance.chequeID,
      'scanPayStatus': instance.scanPayStatus,
      'scanPayID': instance.scanPayID,
      'upiStatus': instance.upiStatus,
      'upiid': instance.upiid,
      'exchangeStatus': instance.exchangeStatus,
      'exchangeID': instance.exchangeID,
      'ifscCode': instance.ifscCode,
      'charge': instance.charge,
      'rImageUrl': instance.rImageUrl,
      'isbankLogoAvailable': instance.isbankLogoAvailable,
      'upinUmber': instance.upinumber,
    };