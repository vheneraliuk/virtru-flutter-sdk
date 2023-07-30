import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:collection/collection.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_lib;
import 'package:virtru_sdk_flutter/virtru_sdk_flutter.dart';

final userId1 = Platform.environment["TEST_USER_ID_1"]!;
final appId1 = Platform.environment["TEST_APP_ID_1"]!;
final userId2 = Platform.environment["TEST_USER_ID_2"]!;
final appId2 = Platform.environment["TEST_APP_ID_2"]!;

void main() {
  late Client client1;
  late Client client2;

  initAppIdClients() {
    client1 = Client.withAppId(userId: userId1, appId: appId1);
    client1.setConsoleLoggingLevel(LogLevel.fatal);
    client2 = Client.withAppId(userId: userId2, appId: appId2);
    client2.setConsoleLoggingLevel(LogLevel.fatal);
  }

  disposeAppIdClients() {
    client1.dispose();
    client2.dispose();
  }

  test("Wrong AppID and UserId", () async {
    const testData = "Wrong AppID and UserId";
    final client =
        Client.withAppId(userId: "fake@user.id", appId: "fake_app_id");
    client.setConsoleLoggingLevel(LogLevel.fatal);
    final shouldThrowError =
        client.encryptString(EncryptStringParams(testData));
    await expectLater(shouldThrowError, throwsA(isA<NativeError>()));
    client.dispose();
  });

  test("Wrong OIDC Credentials", () async {
    const testData = "Wrong OIDC Credentials";
    final client = Client.withOIDC(
        clientId: "fake_client_id",
        clientSecret: "fake_secret",
        organizationName: "fake_name",
        owner: "fake@owner.com");
    client.setConsoleLoggingLevel(LogLevel.fatal);
    final shouldThrowError =
        client.encryptString(EncryptStringParams(testData));
    await expectLater(shouldThrowError, throwsA(isA<NativeError>()));
    client.dispose();
  });

  group("Encrypt/Decrypt Strings:", () {
    setUp(initAppIdClients);
    tearDown(disposeAppIdClients);

    test("String -> RCA -> String", () async {
      const testData = "String -> RCA -> String";
      final rcaLink = await client1.encryptStringToRCA(
        EncryptStringParams(testData)
          ..shareWithUsers([userId2])
          ..setDisplayName("$testData.txt")
          ..setMimeType(ContentType.text.mimeType)
          ..setDisplayMessage(_displayMessage(testData)),
      );
      final decryptedText = await client2.decryptRcaToString(rcaLink);
      expect(testData, equals(decryptedText));
    });

    test("RCA - Persistent Protection Enabled", () async {
      const testData = "RCA - Persistent Protection Enabled";
      final rcaLink =
          await client1.encryptStringToRCA(EncryptStringParams(testData)
            ..shareWithUsers([userId2])
            ..setDisplayName("$testData.txt")
            ..setDisplayMessage(_displayMessage(testData))
            ..setMimeType(ContentType.text.mimeType)
            ..setPolicy(
              Policy()..setPersistentProtectionEnabled(true),
            ));
      final decryptRcaToString = client2.decryptRcaToString(rcaLink);
      expectLater(decryptRcaToString, throwsA(isA<NativeError>()));
    });

    test("RCA - Watermark Enabled", () async {
      const testData = "RCA - Watermark Enabled";
      final rcaLink = await client2.encryptStringToRCA(
        EncryptStringParams(testData)
          ..shareWithUsers([userId1])
          ..setDisplayName("$testData.txt")
          ..setDisplayMessage(_displayMessage(testData))
          ..setMimeType(ContentType.text.mimeType)
          ..setPolicy(
            Policy()..setWatermarkEnabled(true),
          ),
      );
      final decryptRcaToString = client1.decryptRcaToString(rcaLink);
      expectLater(decryptRcaToString, throwsA(isA<NativeError>()));
    });

    test("RCA - Set Expiration", () async {
      const testData = "RCA - Set Expiration";
      final rcaLink = await client2.encryptStringToRCA(
        EncryptStringParams(testData)
          ..shareWithUsers([userId1])
          ..setDisplayName("$testData.txt")
          ..setMimeType(ContentType.text.mimeType)
          ..setPolicy(
            Policy()
              ..setExpirationDate(DateTime.now().add(
                const Duration(seconds: 10),
              )),
          ),
      );

      final decryptedText = await client1.decryptRcaToString(rcaLink);
      expect(testData, equals(decryptedText));

      await Future.delayed(const Duration(seconds: 10));

      final decryptRcaToString = client1.decryptRcaToString(rcaLink);
      expectLater(decryptRcaToString, throwsA(isA<NativeError>()));
    });

    test("String -> TDF3 -> String", () async {
      const testData = "String -> TDF3 -> String";
      final tdf3String = await client2.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers([userId1])
          ..setDisplayName("$testData.txt")
          ..setMimeType(ContentType.text.mimeType)
          ..setDisplayMessage(_displayMessage(testData)),
      );
      final decryptedText = await client1.decryptString(tdf3String);
      expect(testData, equals(decryptedText));
    });

    test("TDF3 - Persistent Protection Enabled", () async {
      const testData = "TDF3 - Persistent Protection Enabled";
      final tdf3String = await client2.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers([userId1])
          ..setDisplayName("$testData.txt")
          ..setDisplayMessage(_displayMessage(testData))
          ..setMimeType(ContentType.text.mimeType)
          ..setPolicy(
            Policy()..setPersistentProtectionEnabled(true),
          ),
      );
      final decryptString = client1.decryptString(tdf3String);
      expectLater(decryptString, throwsA(isA<NativeError>()));
    });

    test("TDF3 - Watermark Enabled", () async {
      const testData = "TDF3 - Watermark Enabled";
      final tdf3String = await client1.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers([userId2])
          ..setDisplayName("$testData.txt")
          ..setDisplayMessage(_displayMessage(testData))
          ..setMimeType(ContentType.text.mimeType)
          ..setPolicy(
            Policy()..setWatermarkEnabled(true),
          ),
      );
      final decryptString = client2.decryptString(tdf3String);
      expectLater(decryptString, throwsA(isA<NativeError>()));
    });

    test("TDF3 - Set Expiration", () async {
      const testData = "TDF3 - Set Expiration";
      final tdf3String = await client1.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers([userId2])
          ..setDisplayName("$testData.txt")
          ..setDisplayMessage(_displayMessage(testData))
          ..setMimeType(ContentType.text.mimeType)
          ..setPolicy(
            Policy()
              ..setExpirationDate(DateTime.now().add(
                const Duration(seconds: 10),
              )),
          ),
      );
      final decryptedText = await client2.decryptString(tdf3String);
      expect(testData, equals(decryptedText));

      await Future.delayed(const Duration(seconds: 10));

      final decryptString = client2.decryptString(tdf3String);
      expectLater(decryptString, throwsA(isA<NativeError>()));
    });
  });

  group("Encrypt/Decrypt Files:", () {
    setUp(initAppIdClients);
    tearDown(disposeAppIdClients);

    test("File -> RCA -> File", () async {
      final bytes = await rootBundle.load("assets/flutter.png");
      const inputFilePath = "flutter.png";
      final inputFile = XFile.fromData(
        bytes.buffer.asUint8List(),
        path: inputFilePath,
      );
      await inputFile.saveTo(inputFilePath);
      final rcaLink = await client1.encryptFileToRCA(
        EncryptFileToRcaParams(inputFile)
          ..setDisplayName("File -> RCA -> File")
          ..setDisplayMessage(_displayMessage("File -> RCA -> File"))
          ..setMimeType("image/png")
          ..shareWithUsers([userId2]),
      );
      const decryptedFilePath = "flutter_decrypted.png";
      final decryptedFile =
          await client2.decryptRcaToFile(rcaLink, XFile(decryptedFilePath));
      final actualBytes = await inputFile.readAsBytes();
      final expectedBytes = await decryptedFile.readAsBytes();
      expect(actualBytes, equals(expectedBytes));
      await inputFile.delete();
      await decryptedFile.delete();
    });

    test("RCA - Watermark Enabled", () async {
      final bytes = await rootBundle.load("assets/flutter.png");
      const inputFilePath = "flutter.png";
      final inputFile = XFile.fromData(
        bytes.buffer.asUint8List(),
        path: inputFilePath,
      );
      await inputFile.saveTo(inputFilePath);
      final rcaLink = await client1.encryptFileToRCA(
        EncryptFileToRcaParams(inputFile)
          ..shareWithUsers([userId2])
          ..setDisplayName("RCA - Watermark Enabled")
          ..setDisplayMessage(_displayMessage("RCA - Watermark Enabled"))
          ..setMimeType("image/png")
          ..setPolicy(
            Policy()..setWatermarkEnabled(true),
          ),
      );
      const decryptedFilePath = "flutter_decrypted.png";
      final decryptRcaToFile =
          client2.decryptRcaToFile(rcaLink, XFile(decryptedFilePath));
      expectLater(decryptRcaToFile, throwsA(isA<NativeError>()));
      await inputFile.delete();
    });

    test("File -> TDF3 -> File", () async {
      final bytes = await rootBundle.load("assets/flutter.png");
      const inputFilePath = "flutter.png";
      const outputFilePath = "flutter.png.tdf.html";
      final inputFile = XFile.fromData(
        bytes.buffer.asUint8List(),
        path: inputFilePath,
      );
      await inputFile.saveTo(inputFilePath);
      final encryptedFile = await client2.encryptFile(
        EncryptFileToFileParams(inputFile, XFile(outputFilePath))
          ..setDisplayName("File -> TDF3 -> File")
          ..setDisplayMessage(_displayMessage("File -> TDF3 -> File"))
          ..setMimeType("image/png")
          ..shareWithUsers([userId1]),
      );
      const decryptedFilePath = "flutter_decrypted.png";
      final decryptedFile =
          await client1.decryptFile(encryptedFile, XFile(decryptedFilePath));
      final actualBytes = await inputFile.readAsBytes();
      final expectedBytes = await decryptedFile.readAsBytes();
      expect(actualBytes, equals(expectedBytes));
      await inputFile.delete();
      await encryptedFile.delete();
      await decryptedFile.delete();
    });

    test("File - Watermark Enabled", () async {
      final bytes = await rootBundle.load("assets/flutter.png");
      const inputFilePath = "flutter.png";
      const outputFilePath = "flutter.png.tdf.html";
      final inputFile = XFile.fromData(
        bytes.buffer.asUint8List(),
        path: inputFilePath,
      );
      await inputFile.saveTo(inputFilePath);
      final encryptedFile = await client1.encryptFile(
        EncryptFileToFileParams(inputFile, XFile(outputFilePath))
          ..shareWithUsers([userId2])
          ..setDisplayName("File - Watermark Enabled")
          ..setDisplayMessage(_displayMessage("File - Watermark Enabled"))
          ..setMimeType("image/png")
          ..setPolicy(
            Policy()..setWatermarkEnabled(true),
          ),
      );
      const decryptedFilePath = "flutter_decrypted.png";
      final decryptFile =
          client1.decryptFile(encryptedFile, XFile(decryptedFilePath));
      expectLater(decryptFile, throwsA(isA<NativeError>()));
      await inputFile.delete();
      await encryptedFile.delete();
    });

    test("File -> ZIP -> File", () async {
      final bytes = await rootBundle.load("assets/flutter.png");
      const inputFilePath = "flutter.png";
      const outputFilePath = "flutter.png.tdf.zip";
      final inputFile = XFile.fromData(
        bytes.buffer.asUint8List(),
        path: inputFilePath,
      );
      await inputFile.saveTo(inputFilePath);
      client1.setZipProtocol(true);
      final encryptedFile = await client1.encryptFile(
        EncryptFileToFileParams(inputFile, XFile(outputFilePath))
          ..setDisplayName("File -> ZIP -> File")
          ..setDisplayMessage(_displayMessage("File -> ZIP -> File"))
          ..setMimeType("image/png")
          ..shareWithUsers([userId2]),
      );
      final extractedDir = Directory("encryptedFile");
      await extractFileToDisk(encryptedFile.path, extractedDir.path);
      final filesInDir = extractedDir
          .listSync()
          .map((e) => path_lib.basename(e.path))
          .toList();
      expect(filesInDir.length, equals(2));
      expect(
        const ListEquality<String>()
            .equals(filesInDir, ["0.manifest.json", "0.payload"]),
        true,
      );
      const decryptedFilePath = "flutter_decrypted.png";
      final decryptedFile =
          await client2.decryptFile(encryptedFile, XFile(decryptedFilePath));
      final actualBytes = await inputFile.readAsBytes();
      final expectedBytes = await decryptedFile.readAsBytes();
      expect(actualBytes, equals(expectedBytes));
      await inputFile.delete();
      await encryptedFile.delete();
      await decryptedFile.delete();
      await extractedDir.delete(recursive: true);
    });
  });
}

_displayMessage(String testName) => "Flutter SDK test: '$testName'";

extension Delete on XFile {
  delete() async {
    if (!kIsWeb) {
      await File(path).delete();
    }
  }
}
