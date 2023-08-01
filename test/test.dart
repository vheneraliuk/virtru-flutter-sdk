import 'dart:io';
import 'dart:math';

import 'package:archive/archive_io.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path_lib;
import 'package:virtru_sdk_flutter/virtru_sdk_flutter.dart';

final userId1 = Platform.environment["TEST_USER_ID_1"]!;
final appId1 = Platform.environment["TEST_APP_ID_1"]!;
final userId2 = Platform.environment["TEST_USER_ID_2"]!;
final appId2 = Platform.environment["TEST_APP_ID_2"]!;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
      final encryptedResult = await client1.encryptStringToRCA(
        EncryptStringParams(testData)
          ..shareWithUsers([userId2])
          ..setDisplayName("$testData.txt")
          ..setMimeType(ContentType.text.mimeType)
          ..setDisplayMessage(_displayMessage(testData)),
      );
      final rcaLink = encryptedResult.result;
      final decryptedText = await client2.decryptRcaToString(rcaLink);
      expect(decryptedText, equals(testData));
    });

    test("RCA - Persistent Protection Enabled", () async {
      const testData = "RCA - Persistent Protection Enabled";
      final encryptedResult =
          await client1.encryptStringToRCA(EncryptStringParams(testData)
            ..shareWithUsers([userId2])
            ..setDisplayName("$testData.txt")
            ..setDisplayMessage(_displayMessage(testData))
            ..setMimeType(ContentType.text.mimeType)
            ..setPolicy(
              Policy()..setPersistentProtectionEnabled(true),
            ));
      final rcaLink = encryptedResult.result;
      final decryptRcaToString = client2.decryptRcaToString(rcaLink);
      await expectLater(decryptRcaToString, throwsA(isA<NativeError>()));
    });

    test("RCA - Watermark Enabled", () async {
      const testData = "RCA - Watermark Enabled";
      final encryptedResult = await client2.encryptStringToRCA(
        EncryptStringParams(testData)
          ..shareWithUsers([userId1])
          ..setDisplayName("$testData.txt")
          ..setDisplayMessage(_displayMessage(testData))
          ..setMimeType(ContentType.text.mimeType)
          ..setPolicy(
            Policy()..setWatermarkEnabled(true),
          ),
      );
      final rcaLink = encryptedResult.result;
      final decryptRcaToString = client1.decryptRcaToString(rcaLink);
      await expectLater(decryptRcaToString, throwsA(isA<NativeError>()));
    });

    test("RCA - Set Expiration", () async {
      const testData = "RCA - Set Expiration";
      final encryptedResult = await client2.encryptStringToRCA(
        EncryptStringParams(testData)
          ..shareWithUsers([userId1])
          ..setDisplayName("$testData.txt")
          ..setMimeType(ContentType.text.mimeType)
          ..setPolicy(
            Policy()
              ..setExpirationDate(DateTime.now().add(
                const Duration(seconds: 15),
              )),
          ),
      );

      final rcaLink = encryptedResult.result;
      final decryptedText = await client1.decryptRcaToString(rcaLink);
      expect(decryptedText, equals(testData));

      await Future.delayed(const Duration(seconds: 15));

      final decryptRcaToString = client1.decryptRcaToString(rcaLink);
      await expectLater(decryptRcaToString, throwsA(isA<NativeError>()));
    });

    test("RCA - Remove Users", () async {
      const testData = "RCA - Remove users";
      final encryptedResult = await client2.encryptStringToRCA(
        EncryptStringParams(testData)
          ..shareWithUsers([userId1])
          ..setDisplayName("$testData.txt")
          ..setMimeType(ContentType.text.mimeType)
          ..setDisplayMessage(_displayMessage(testData)),
      );
      final rcaLink = encryptedResult.result;
      final decryptedText = await client1.decryptRcaToString(rcaLink);
      expect(decryptedText, equals(testData));

      final policy = await client2.fetchPolicyById(encryptedResult.policyId);
      policy.removeUsers([userId1]);
      await client2.updatePolicyForId(policy, encryptedResult.policyId);
      policy.dispose();

      final decryptRcaToString = client1.decryptRcaToString(rcaLink);
      await expectLater(decryptRcaToString, throwsA(isA<NativeError>()));
    });

    test("RCA - Revoke Access", () async {
      const testData = "RCA - Revoke Access";
      final encryptedResult = await client1.encryptStringToRCA(
        EncryptStringParams(testData)
          ..shareWithUsers([userId2])
          ..setDisplayName("$testData.txt")
          ..setMimeType(ContentType.text.mimeType)
          ..setDisplayMessage(_displayMessage(testData)),
      );
      final rcaLink = encryptedResult.result;
      final decryptedText = await client2.decryptRcaToString(rcaLink);
      expect(decryptedText, equals(testData));

      await client1.revokePolicy(encryptedResult.policyId);

      final decryptRcaToString = client2.decryptRcaToString(rcaLink);
      await expectLater(decryptRcaToString, throwsA(isA<NativeError>()));
    });

    test("RCA - Wrong Recipient", () async {
      const testData = "RCA - Wrong Recipient";
      final encryptStringToRCA = client1.encryptStringToRCA(
        EncryptStringParams(testData)
          ..shareWithUsers(["fake_user_email"])
          ..setDisplayName("$testData.txt")
          ..setMimeType(ContentType.text.mimeType)
          ..setDisplayMessage(_displayMessage(testData)),
      );
      await expectLater(encryptStringToRCA, throwsA(isA<NativeError>()));
    });

    test("String -> TDF3 -> String", () async {
      const testData = "String -> TDF3 -> String";
      final encryptedResult = await client2.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers([userId1])
          ..setDisplayName("$testData.txt")
          ..setMimeType(ContentType.text.mimeType)
          ..setDisplayMessage(_displayMessage(testData)),
      );
      final tdf3String = encryptedResult.result;
      final decryptedText = await client1.decryptString(tdf3String);
      expect(decryptedText, equals(testData));
    });

    test("TDF3 - Policy initial statuses", () async {
      const testData = "TDF3 - Policy initial statuses";
      final encryptedResult = await client1.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers([userId2])
          ..setDisplayName("$testData.txt")
          ..setMimeType(ContentType.text.mimeType)
          ..setDisplayMessage(_displayMessage(testData)),
      );
      final policy = await client1.fetchPolicyById(encryptedResult.policyId);

      final owner = policy.getOwner();
      expect(owner, equals(userId1));

      final expiration = policy.getExpirationDate();
      expect(expiration, equals(null));

      final copyEnabled = policy.isCopyEnabled();
      expect(copyEnabled, equals(true));

      final printEnabled = policy.isPrintEnabled();
      expect(printEnabled, equals(true));

      final reshareEnabled = policy.isReshareEnabled();
      expect(reshareEnabled, equals(true));

      final persistentProtectionEnabled =
          policy.isPersistentProtectionEnabled();
      expect(persistentProtectionEnabled, equals(false));

      final watermarkEnabled = policy.isWatermarkEnabled();
      expect(watermarkEnabled, equals(false));

      final preventDownloadEnabled = policy.isPreventDownloadEnabled();
      expect(preventDownloadEnabled, equals(false));

      final sharedUsers = policy.getSharedUsers();
      expect(
        const DeepCollectionEquality.unordered()
            .equals(sharedUsers, [userId2, userId1]),
        true,
      );
      policy.dispose();
    });

    test("TDF3 - Policy statuses", () async {
      const testData = "TDF3 - Policy statuses";
      final expiration = DateTime.now().add(Duration(
        days: Random().nextInt(100),
      ));
      final copy = Random().nextBool();
      final print = Random().nextBool();
      final reshare = Random().nextBool();
      final persistentProtection = Random().nextBool();
      final watermark = Random().nextBool();
      final preventDownload = Random().nextBool();
      final shareWith = [userId2, "example1@user.com", "example2@user.com"];

      final params = EncryptStringParams(testData)
        ..setPolicy(Policy()
          ..setExpirationDate(expiration)
          ..setCopyEnabled(copy)
          ..setPrintEnabled(print)
          ..setReshareEnabled(reshare)
          ..setPersistentProtectionEnabled(persistentProtection)
          ..setWatermarkEnabled(watermark)
          ..setPreventDownloadEnabled(preventDownload))
        ..shareWithUsers(shareWith)
        ..setDisplayName("$testData.txt")
        ..setMimeType(ContentType.text.mimeType)
        ..setDisplayMessage(_displayMessage(testData));

      final encryptedResult = await client1.encryptString(params);
      final policy = await client1.fetchPolicyById(encryptedResult.policyId);

      final rOwner = policy.getOwner();
      expect(rOwner, equals(userId1));

      final rExpiration = policy.getExpirationDate();
      expect(rExpiration!.difference(expiration).inSeconds, equals(0));

      final rCopyEnabled = policy.isCopyEnabled();
      expect(rCopyEnabled, equals(copy));

      final rPrintEnabled = policy.isPrintEnabled();
      expect(rPrintEnabled, equals(print));

      final rReshareEnabled = policy.isReshareEnabled();
      expect(rReshareEnabled, equals(reshare));

      final rPersistentProtectionEnabled =
          policy.isPersistentProtectionEnabled();
      expect(rPersistentProtectionEnabled, equals(persistentProtection));

      final rWatermarkEnabled = policy.isWatermarkEnabled();
      expect(rWatermarkEnabled, equals(watermark));

      final rPreventDownloadEnabled = policy.isPreventDownloadEnabled();
      expect(rPreventDownloadEnabled, equals(preventDownload));

      final rSharedUsers = policy.getSharedUsers();
      final expectedSharedUsers = List<String>.from(shareWith)..add(userId1);
      expect(
          const DeepCollectionEquality.unordered()
              .equals(rSharedUsers, expectedSharedUsers),
          true);
      policy.dispose();
    });

    test("TDF3 - Persistent Protection Enabled", () async {
      const testData = "TDF3 - Persistent Protection Enabled";
      final encryptedResult = await client2.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers([userId1])
          ..setDisplayName("$testData.txt")
          ..setDisplayMessage(_displayMessage(testData))
          ..setMimeType(ContentType.text.mimeType)
          ..setPolicy(
            Policy()..setPersistentProtectionEnabled(true),
          ),
      );
      final tdf3String = encryptedResult.result;
      final decryptString = client1.decryptString(tdf3String);
      await expectLater(decryptString, throwsA(isA<NativeError>()));
    });

    test("TDF3 - Watermark Enabled", () async {
      const testData = "TDF3 - Watermark Enabled";
      final encryptedResult = await client1.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers([userId2])
          ..setDisplayName("$testData.txt")
          ..setDisplayMessage(_displayMessage(testData))
          ..setMimeType(ContentType.text.mimeType)
          ..setPolicy(
            Policy()..setWatermarkEnabled(true),
          ),
      );
      final tdf3String = encryptedResult.result;
      final decryptString = client2.decryptString(tdf3String);
      await expectLater(decryptString, throwsA(isA<NativeError>()));
    });

    test("TDF3 - Set Expiration", () async {
      const testData = "TDF3 - Set Expiration";
      final encryptedResult = await client1.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers([userId2])
          ..setDisplayName("$testData.txt")
          ..setDisplayMessage(_displayMessage(testData))
          ..setMimeType(ContentType.text.mimeType)
          ..setPolicy(
            Policy()
              ..setExpirationDate(DateTime.now().add(
                const Duration(seconds: 15),
              )),
          ),
      );
      final tdf3String = encryptedResult.result;
      final decryptedText = await client2.decryptString(tdf3String);
      expect(decryptedText, equals(testData));

      await Future.delayed(const Duration(seconds: 15));

      final decryptString = client2.decryptString(tdf3String);
      await expectLater(decryptString, throwsA(isA<NativeError>()));
    });

    test("TDF3 - Remove Users", () async {
      const testData = "TDF3 - Remove users";
      final encryptedResult = await client2.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers([userId1])
          ..setDisplayName("$testData.txt")
          ..setMimeType(ContentType.text.mimeType)
          ..setDisplayMessage(_displayMessage(testData)),
      );
      final tdf3String = encryptedResult.result;
      final decryptedText = await client1.decryptString(tdf3String);
      expect(decryptedText, equals(testData));

      final policy = await client2.fetchPolicyById(encryptedResult.policyId);
      policy.removeUsers([userId1]);
      await client2.updatePolicyForId(policy, encryptedResult.policyId);
      policy.dispose();

      final decryptString = client1.decryptString(tdf3String);
      await expectLater(decryptString, throwsA(isA<NativeError>()));
    });

    test("TDF3 - Revoke Access", () async {
      const testData = "TDF3 - Revoke Access";
      final encryptedResult = await client1.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers([userId2])
          ..setDisplayName("$testData.txt")
          ..setMimeType(ContentType.text.mimeType)
          ..setDisplayMessage(_displayMessage(testData)),
      );
      final tdf3String = encryptedResult.result;
      final decryptedText = await client2.decryptString(tdf3String);
      expect(decryptedText, equals(testData));

      await client1.revokePolicy(encryptedResult.policyId);

      final decryptString = client2.decryptString(tdf3String);
      await expectLater(decryptString, throwsA(isA<NativeError>()));
    });

    test("TDF3 - Wrong Recipient", () async {
      const testData = "TDF3 - Wrong Recipient";
      final encryptString = client1.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers(["fake_user_email"])
          ..setDisplayName("$testData.txt")
          ..setMimeType(ContentType.text.mimeType)
          ..setDisplayMessage(_displayMessage(testData)),
      );
      await expectLater(encryptString, throwsA(isA<NativeError>()));
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
      final encryptedResult = await client1.encryptFileToRCA(
        EncryptFileToRcaParams(inputFile)
          ..setDisplayName("File -> RCA -> File")
          ..setDisplayMessage(_displayMessage("File -> RCA -> File"))
          ..setMimeType("image/png")
          ..shareWithUsers([userId2]),
      );
      final rcaLink = encryptedResult.result;
      const decryptedFilePath = "flutter_decrypted.png";
      final decryptedFile =
          await client2.decryptRcaToFile(rcaLink, XFile(decryptedFilePath));
      final actualBytes = await decryptedFile.readAsBytes();
      final expectedBytes = await inputFile.readAsBytes();
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
      final encryptedResult = await client1.encryptFileToRCA(
        EncryptFileToRcaParams(inputFile)
          ..shareWithUsers([userId2])
          ..setDisplayName("RCA - Watermark Enabled")
          ..setDisplayMessage(_displayMessage("RCA - Watermark Enabled"))
          ..setMimeType("image/png")
          ..setPolicy(
            Policy()..setWatermarkEnabled(true),
          ),
      );
      final rcaLink = encryptedResult.result;
      const decryptedFilePath = "flutter_decrypted.png";
      final decryptRcaToFile =
          client2.decryptRcaToFile(rcaLink, XFile(decryptedFilePath));
      await expectLater(decryptRcaToFile, throwsA(isA<NativeError>()));
      await inputFile.delete();
    });

    test("RCA - Remove Users", () async {
      final bytes = await rootBundle.load("assets/flutter.png");
      const inputFilePath = "flutter.png";
      final inputFile = XFile.fromData(
        bytes.buffer.asUint8List(),
        path: inputFilePath,
      );
      await inputFile.saveTo(inputFilePath);
      final encryptedResult = await client2.encryptFileToRCA(
        EncryptFileToRcaParams(inputFile)
          ..setDisplayName("RCA - Remove Users")
          ..setDisplayMessage(_displayMessage("RCA - Remove Users"))
          ..setMimeType("image/png")
          ..shareWithUsers([userId1]),
      );
      final rcaLink = encryptedResult.result;
      const decryptedFilePath = "flutter_decrypted.png";
      final decryptedFile =
          await client1.decryptRcaToFile(rcaLink, XFile(decryptedFilePath));
      final actualBytes = await decryptedFile.readAsBytes();
      final expectedBytes = await inputFile.readAsBytes();
      expect(actualBytes, equals(expectedBytes));

      final policy = await client2.fetchPolicyById(encryptedResult.policyId);
      policy.removeUsers([userId1]);
      await client2.updatePolicyForId(policy, encryptedResult.policyId);
      policy.dispose();

      final decryptRcaToFile =
          client1.decryptRcaToFile(rcaLink, XFile(decryptedFilePath));
      await expectLater(decryptRcaToFile, throwsA(isA<NativeError>()));

      await inputFile.delete();
      await decryptedFile.delete();
    });

    test("RCA - Revoke Access", () async {
      final bytes = await rootBundle.load("assets/flutter.png");
      const inputFilePath = "flutter.png";
      final inputFile = XFile.fromData(
        bytes.buffer.asUint8List(),
        path: inputFilePath,
      );
      await inputFile.saveTo(inputFilePath);
      final encryptedResult = await client1.encryptFileToRCA(
        EncryptFileToRcaParams(inputFile)
          ..setDisplayName("RCA - Revoke Access")
          ..setDisplayMessage(_displayMessage("RCA - Revoke Access"))
          ..setMimeType("image/png")
          ..shareWithUsers([userId2]),
      );
      final rcaLink = encryptedResult.result;
      const decryptedFilePath = "flutter_decrypted.png";
      final decryptedFile =
          await client2.decryptRcaToFile(rcaLink, XFile(decryptedFilePath));
      final actualBytes = await decryptedFile.readAsBytes();
      final expectedBytes = await inputFile.readAsBytes();
      expect(actualBytes, equals(expectedBytes));

      client1.revokePolicy(encryptedResult.policyId);

      final decryptRcaToFile =
          client2.decryptRcaToFile(rcaLink, XFile(decryptedFilePath));
      await expectLater(decryptRcaToFile, throwsA(isA<NativeError>()));

      await inputFile.delete();
      await decryptedFile.delete();
    });

    test("RCA - Wrong Recipient", () async {
      final bytes = await rootBundle.load("assets/flutter.png");
      const inputFilePath = "flutter.png";
      final inputFile = XFile.fromData(
        bytes.buffer.asUint8List(),
        path: inputFilePath,
      );
      await inputFile.saveTo(inputFilePath);
      final encryptFileToRCA =
          client2.encryptFileToRCA(EncryptFileToRcaParams(inputFile)
            ..shareWithUsers(["fake_user_email"])
            ..setDisplayName("RCA - Wrong Recipient")
            ..setDisplayMessage(_displayMessage("RCA - Wrong Recipient"))
            ..setMimeType("image/png"));
      await expectLater(encryptFileToRCA, throwsA(isA<NativeError>()));
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
      final encryptedResult = await client2.encryptFile(
        EncryptFileToFileParams(inputFile, XFile(outputFilePath))
          ..setDisplayName("File -> TDF3 -> File")
          ..setDisplayMessage(_displayMessage("File -> TDF3 -> File"))
          ..setMimeType("image/png")
          ..shareWithUsers([userId1]),
      );
      final encryptedFile = encryptedResult.result;
      const decryptedFilePath = "flutter_decrypted.png";
      final decryptedFile =
          await client1.decryptFile(encryptedFile, XFile(decryptedFilePath));
      final actualBytes = await decryptedFile.readAsBytes();
      final expectedBytes = await inputFile.readAsBytes();
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
      final encryptedResult = await client1.encryptFile(
        EncryptFileToFileParams(inputFile, XFile(outputFilePath))
          ..shareWithUsers([userId2])
          ..setDisplayName("File - Watermark Enabled")
          ..setDisplayMessage(_displayMessage("File - Watermark Enabled"))
          ..setMimeType("image/png")
          ..setPolicy(
            Policy()..setWatermarkEnabled(true),
          ),
      );
      final encryptedFile = encryptedResult.result;
      const decryptedFilePath = "flutter_decrypted.png";
      final decryptFile =
          client1.decryptFile(encryptedFile, XFile(decryptedFilePath));
      await expectLater(decryptFile, throwsA(isA<NativeError>()));
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
      final encryptedResult = await client1.encryptFile(
        EncryptFileToFileParams(inputFile, XFile(outputFilePath))
          ..setDisplayName("File -> ZIP -> File")
          ..setDisplayMessage(_displayMessage("File -> ZIP -> File"))
          ..setMimeType("image/png")
          ..shareWithUsers([userId2]),
      );
      final encryptedFile = encryptedResult.result;
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
      final actualBytes = await decryptedFile.readAsBytes();
      final expectedBytes = await inputFile.readAsBytes();
      expect(actualBytes, equals(expectedBytes));
      await inputFile.delete();
      await encryptedFile.delete();
      await decryptedFile.delete();
      await extractedDir.delete(recursive: true);
    });

    test("File - Remove Users", () async {
      final bytes = await rootBundle.load("assets/flutter.png");
      const inputFilePath = "flutter.png";
      const outputFilePath = "flutter.png.tdf.html";
      final inputFile = XFile.fromData(
        bytes.buffer.asUint8List(),
        path: inputFilePath,
      );
      await inputFile.saveTo(inputFilePath);
      final encryptedResult = await client2.encryptFile(
        EncryptFileToFileParams(inputFile, XFile(outputFilePath))
          ..setDisplayName("File - Remove Users")
          ..setDisplayMessage(_displayMessage("File - Remove Users"))
          ..setMimeType("image/png")
          ..shareWithUsers([userId1]),
      );
      final encryptedFile = encryptedResult.result;
      const decryptedFilePath = "flutter_decrypted.png";
      final decryptedFile =
          await client1.decryptFile(encryptedFile, XFile(decryptedFilePath));
      final actualBytes = await decryptedFile.readAsBytes();
      final expectedBytes = await inputFile.readAsBytes();
      expect(actualBytes, equals(expectedBytes));

      final policy = await client2.fetchPolicyById(encryptedResult.policyId);
      policy.removeUsers([userId1]);
      await client2.updatePolicyForFile(policy, encryptedFile);
      policy.dispose();

      final decryptFile =
          client1.decryptFile(encryptedFile, XFile(decryptedFilePath));
      await expectLater(decryptFile, throwsA(isA<NativeError>()));

      await inputFile.delete();
      await encryptedFile.delete();
      await decryptedFile.delete();
    });

    test("File - Revoke Access", () async {
      final bytes = await rootBundle.load("assets/flutter.png");
      const inputFilePath = "flutter.png";
      const outputFilePath = "flutter.png.tdf.html";
      final inputFile = XFile.fromData(
        bytes.buffer.asUint8List(),
        path: inputFilePath,
      );
      await inputFile.saveTo(inputFilePath);
      final encryptedResult = await client2.encryptFile(
        EncryptFileToFileParams(inputFile, XFile(outputFilePath))
          ..setDisplayName("File - Revoke Access")
          ..setDisplayMessage(_displayMessage("File - Revoke Access"))
          ..setMimeType("image/png")
          ..shareWithUsers([userId1]),
      );
      final encryptedFile = encryptedResult.result;
      const decryptedFilePath = "flutter_decrypted.png";
      final decryptedFile =
          await client1.decryptFile(encryptedFile, XFile(decryptedFilePath));
      final actualBytes = await decryptedFile.readAsBytes();
      final expectedBytes = await inputFile.readAsBytes();
      expect(actualBytes, equals(expectedBytes));

      client2.revokeFile(encryptedFile);

      final decryptFile =
          client1.decryptFile(encryptedFile, XFile(decryptedFilePath));
      await expectLater(decryptFile, throwsA(isA<NativeError>()));

      await inputFile.delete();
      await encryptedFile.delete();
      await decryptedFile.delete();
    });

    test("File - Wrong Recipient", () async {
      final bytes = await rootBundle.load("assets/flutter.png");
      const inputFilePath = "flutter.png";
      const outputFilePath = "flutter.png.tdf.html";
      final inputFile = XFile.fromData(
        bytes.buffer.asUint8List(),
        path: inputFilePath,
      );
      await inputFile.saveTo(inputFilePath);
      final outputFile = XFile(outputFilePath);
      final encryptFile =
          client1.encryptFile(EncryptFileToFileParams(inputFile, outputFile)
            ..shareWithUsers(["fake_user_email"])
            ..setDisplayName("File - Wrong Recipient")
            ..setDisplayMessage(_displayMessage("File - Wrong Recipient"))
            ..setMimeType("image/png"));
      await expectLater(encryptFile, throwsA(isA<NativeError>()));
      await inputFile.delete();
      await outputFile.delete();
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
