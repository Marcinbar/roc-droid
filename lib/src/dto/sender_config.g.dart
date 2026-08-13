// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sender_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SenderConfig _$SenderConfigFromJson(Map<String, dynamic> json) =>
    _SenderConfig(
      captureSource: $enumDecode(_$CaptureSourceEnumMap, json['captureSource']),
      receiverIP: json['receiverIP'] as String,
      receiverSourcePort: (json['receiverSourcePort'] as num).toInt(),
      receiverRepairPort: (json['receiverRepairPort'] as num).toInt(),
    );

Map<String, dynamic> _$SenderConfigToJson(_SenderConfig instance) =>
    <String, dynamic>{
      'captureSource': _$CaptureSourceEnumMap[instance.captureSource]!,
      'receiverIP': instance.receiverIP,
      'receiverSourcePort': instance.receiverSourcePort,
      'receiverRepairPort': instance.receiverRepairPort,
    };

const _$CaptureSourceEnumMap = {
  CaptureSource.captureApps: 'captureApps',
  CaptureSource.captureMic: 'captureMic',
};
