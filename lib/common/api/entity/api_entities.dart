import 'package:json_annotation/json_annotation.dart';

part 'api_entities.g.dart';

@JsonSerializable()
class CreateResult {
  final String uuid;
  final Map<String, dynamic> storageLinks;

  String get payloadUploadUrl => storageLinks['payload']['upload'];

  String get payloadDownloadUrl => storageLinks['payload']['download'];

  String get metadataUploadUrl => storageLinks['metadata']['upload'];

  String get metadataDownloadUrl => storageLinks['metadata']['download'];

  CreateResult(this.uuid, this.storageLinks);

  factory CreateResult.fromJson(Map<String, dynamic> json) =>
      _$CreateResultFromJson(json);

  Map<String, dynamic> toJson() => _$CreateResultToJson(this);
}
