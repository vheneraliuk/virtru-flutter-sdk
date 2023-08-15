// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_entities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateResult _$CreateResultFromJson(Map<String, dynamic> json) => CreateResult(
      json['uuid'] as String,
      json['storageLinks'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$CreateResultToJson(CreateResult instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'storageLinks': instance.storageLinks,
    };
