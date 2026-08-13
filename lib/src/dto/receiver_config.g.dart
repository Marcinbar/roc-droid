// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receiver_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReceiverConfig _$ReceiverConfigFromJson(Map<String, dynamic> json) =>
    _ReceiverConfig(
      sourcePort: (json['sourcePort'] as num).toInt(),
      repairPort: (json['repairPort'] as num).toInt(),
    );

Map<String, dynamic> _$ReceiverConfigToJson(_ReceiverConfig instance) =>
    <String, dynamic>{
      'sourcePort': instance.sourcePort,
      'repairPort': instance.repairPort,
    };
