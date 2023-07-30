import 'package:cross_file/cross_file.dart';
import 'package:virtru_sdk_flutter/common/encrypt_params.dart'
    if (dart.library.html) 'package:virtru_sdk_flutter/web/encrypt_params.dart';
import 'package:virtru_sdk_flutter/policy.dart';

/// Encrypt string params for Virtru Client encrypt operations.
abstract class EncryptStringParams {
  /// Create a new encrypt string params with a given [data].
  factory EncryptStringParams(String data) {
    return EncryptStringParamsImpl(data);
  }

  /// Set the policy that to be applied to the TDF.
  /// NOTE: If there is no policy defined for the tdf, default policy settings will be applied.
  setPolicy(Policy policy);

  /// Set the display [name] for the TDF, this name shows up on the Virtru dashboard.
  setDisplayName(String name);

  /// Set the display [message] for the TDF, this message shows up on the Virtru dashboard.
  setDisplayMessage(String message);

  /// Set the [mimeType] (format) of the file that will be encrypted.
  /// NOTE: The default will be 'application/octet-stream' if not specified.
  setMimeType(String mimeType);

  /// Add access to the TDF data for the users in the given [usersEmail] list.
  shareWithUsers(List<String> usersEmail);
}

/// Encrypt file params for Virtru Client encrypt operations.
abstract class EncryptFileParams {
  /// Set the policy that to be applied to the TDF.
  /// NOTE: If there is no policy defined for the tdf, default policy settings will be applied.
  setPolicy(Policy policy);

  /// Set the display [name] for the TDF, this name shows up on the Virtru dashboard.
  /// NOTE: If not set, the basename of [inputFile] will be used.
  setDisplayName(String name);

  /// Set the display [message] for the TDF, this message shows up on the Virtru dashboard.
  setDisplayMessage(String message);

  /// Set the [mimeType] (format) of the file that will be encrypted.
  /// NOTE: The default will be 'application/octet-stream' if not specified
  setMimeType(String mimeType);

  /// Add access to the TDF file for the users in the given [usersEmail] list.
  shareWithUsers(List<String> usersEmail);
}

/// Encrypt file params for Virtru Client encrypt operations.
abstract class EncryptFileToRcaParams implements EncryptFileParams {
  /// Create a new encrypt file param with a given [inputFile].
  factory EncryptFileToRcaParams(XFile inputFile) {
    return EncryptFileParamsImpl.fileToRca(inputFile);
  }
}

/// Encrypt file params for Virtru Client encrypt operations.
abstract class EncryptFileToFileParams implements EncryptFileParams {
  String get outputFilePath;

  /// Create a new encrypt file param with a given [inputFile] and [outputFile].
  factory EncryptFileToFileParams(XFile inputFile, XFile outputFile) {
    return EncryptFileParamsImpl.fileToFile(inputFile, outputFile);
  }
}
