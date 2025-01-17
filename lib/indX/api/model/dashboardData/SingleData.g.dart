// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SingleData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleData _$SingleDataFromJson(Map<String, dynamic> json) => SingleData(
      directDownlinelUser: (json['directDownlinelUser'] as num?)?.toInt(),
      directDownlinelUserActive:
          (json['directDownlinelUserActive'] as num?)?.toInt(),
      directDownlinelUserDeactive:
          (json['directDownlinelUserDeactive'] as num?)?.toInt(),
      allDownlinelUser: (json['allDownlinelUser'] as num?)?.toInt(),
      allDownlinelUserActive: (json['allDownlinelUserActive'] as num?)?.toInt(),
      allDownlinelUserDeActive:
          (json['allDownlinelUserDeActive'] as num?)?.toInt(),
      packageName: json['packageName'] as String?,
      packageAmount: (json['packageAmount'] as num?)?.toDouble(),
      totalSponser: (json['totalSponser'] as num?)?.toInt(),
      totalSponserActive: (json['totalSponserActive'] as num?)?.toInt(),
      totalSponserDeactive: (json['totalSponserDeactive'] as num?)?.toInt(),
      totalTeam: (json['totalTeam'] as num?)?.toInt(),
      totalActive: (json['totalActive'] as num?)?.toInt(),
      totalDeactive: (json['totalDeactive'] as num?)?.toInt(),
      totalLeftTeam: (json['totalLeftTeam'] as num?)?.toInt(),
      totalLeftActive: (json['totalLeftActive'] as num?)?.toInt(),
      totalLeftDeactive: (json['totalLeftDeactive'] as num?)?.toInt(),
      totalRightTeam: (json['totalRightTeam'] as num?)?.toInt(),
      totalRightActive: (json['totalRightActive'] as num?)?.toInt(),
      totalRightDeactive: (json['totalRightDeactive'] as num?)?.toInt(),
      leftBusiness: (json['leftBusiness'] as num?)?.toDouble(),
      rightBusiness: (json['rightBusiness'] as num?)?.toDouble(),
      totalBusiness: (json['totalBusiness'] as num?)?.toDouble(),
      directBusiness: (json['directBusiness'] as num?)?.toDouble(),
      sponserBusiness: (json['sponserBusiness'] as num?)?.toDouble(),
      leftReferralLink: json['leftReferralLink'] as String?,
      rightReferralLink: json['rightReferralLink'] as String?,
      singleLink: json['singleLink'] as String?,
      selfBusiness: (json['selfBusiness'] as num?)?.toDouble(),
      selfBV: (json['selfBV'] as num?)?.toDouble(),
      selfPV: (json['selfPV'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SingleDataToJson(SingleData instance) =>
    <String, dynamic>{
      'directDownlinelUser': instance.directDownlinelUser,
      'directDownlinelUserActive': instance.directDownlinelUserActive,
      'directDownlinelUserDeactive': instance.directDownlinelUserDeactive,
      'allDownlinelUser': instance.allDownlinelUser,
      'allDownlinelUserActive': instance.allDownlinelUserActive,
      'allDownlinelUserDeActive': instance.allDownlinelUserDeActive,
      'packageName': instance.packageName,
      'packageAmount': instance.packageAmount,
      'totalSponser': instance.totalSponser,
      'totalSponserActive': instance.totalSponserActive,
      'totalSponserDeactive': instance.totalSponserDeactive,
      'totalTeam': instance.totalTeam,
      'totalActive': instance.totalActive,
      'totalDeactive': instance.totalDeactive,
      'totalLeftTeam': instance.totalLeftTeam,
      'totalLeftActive': instance.totalLeftActive,
      'totalLeftDeactive': instance.totalLeftDeactive,
      'totalRightTeam': instance.totalRightTeam,
      'totalRightActive': instance.totalRightActive,
      'totalRightDeactive': instance.totalRightDeactive,
      'leftBusiness': instance.leftBusiness,
      'rightBusiness': instance.rightBusiness,
      'totalBusiness': instance.totalBusiness,
      'directBusiness': instance.directBusiness,
      'sponserBusiness': instance.sponserBusiness,
      'leftReferralLink': instance.leftReferralLink,
      'rightReferralLink': instance.rightReferralLink,
      'singleLink': instance.singleLink,
      'selfBusiness': instance.selfBusiness,
      'selfBV': instance.selfBV,
      'selfPV': instance.selfPV,
    };
