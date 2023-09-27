import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:virtru_sdk/entity/metadata.dart';

class SecureShareResult extends Equatable {
  final List<SecureShareMetadata> files;
  final String filesOwner;
  final String openMessage;
  final String encryptedMessage;

  const SecureShareResult._(
      this.files, this.filesOwner, this.openMessage, this.encryptedMessage);

  /// Parses the [metadata] and returns a [SecureShareResult] instance.
  static SecureShareResult? fromMetadata(String metadata) {
    final metadataJson = jsonDecode(metadata);
    if (metadataJson == null) return null;
    final filesOwner = metadataJson['filesOwner'];
    if (filesOwner == null) return null;
    final openMessage = metadataJson['messages']['opening'];
    if (openMessage == null) return null;
    final encryptedMessage = metadataJson['messages']['encrypted'];
    if (encryptedMessage == null) return null;
    final files = <SecureShareMetadata>[];
    final filesJson = metadataJson['files'];
    if (filesJson != null) {
      filesJson.forEach((key, value) {
        final fileJson = value;
        final name = fileJson['name'];
        final size = fileJson['size'];
        final rcaLink = fileJson['rcaLink'];
        final file = SecureShareMetadata(
          policyId: key,
          name: name,
          size: size,
          rcaLink: rcaLink,
        );
        files.add(file);
      });
    }
    return SecureShareResult._(
        files, filesOwner, openMessage, encryptedMessage);
  }

  @override
  List<Object?> get props => [files, filesOwner, openMessage, encryptedMessage];
}
