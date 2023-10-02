@Retry(2)
import 'dart:io';
import 'dart:math';

import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:virtru_sdk/virtru_sdk.dart';

final userId1 = Platform.environment["TEST_USER_ID_1"]!;
final appId1 = Platform.environment["TEST_APP_ID_1"]!;
final userId2 = Platform.environment["TEST_USER_ID_2"]!;
final appId2 = Platform.environment["TEST_APP_ID_2"]!;

void main() {
  late Client client1;
  late Client client2;

  initAppIdClients(userId1, appId1, userId2, appId2) {
    client1 = Client.withAppId(userId: userId1, appId: appId1);
    client1.setConsoleLoggingLevel(LogLevel.fatal);
    client2 = Client.withAppId(userId: userId2, appId: appId2);
    client2.setConsoleLoggingLevel(LogLevel.fatal);
  }

  disposeAppIdClients() {
    client1.dispose();
    client2.dispose();
  }

  stringToTdfToString() async {
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

  group("Secure Share:", () {
    setUp(() => initAppIdClients(userId1, appId1, userId2, appId2));
    tearDown(disposeAppIdClients);

    test("Parse Link", () async {
      const prodLink =
          "https://secure.virtru.com/secure-share/shared/vladyslav.heneraliuk@gmail.com/dee2714f-03ff-4d77-afb2-95165de3083b?utm_source=https%3A%2F%2Fsecure.virtru.com%2F&utm_medium=email&utm_campaign=outbound_view&utm_content=textlink#ek=W%2FJbOnyRE5CjANsRoGiRnWc5mTGpqQw50rcSqY4ZT8w%3D";
      final secureShareProdLink = SecureShareLink.parse(prodLink);
      expect(secureShareProdLink, isNotNull);
      expect(secureShareProdLink!.policyUuid,
          "dee2714f-03ff-4d77-afb2-95165de3083b");
      expect(secureShareProdLink.metadataKey,
          "W/JbOnyRE5CjANsRoGiRnWc5mTGpqQw50rcSqY4ZT8w=");
      expect(secureShareProdLink.env, Environment.prod);
    });

    test("Share files", () async {
      final file1 = XFile('test_data/flutter.png');
      final file2 = XFile('test_data/sensitive.txt');
      const openMessageText = "Flutter SDK unit testing";
      const encryptedMessageText = "Create Secure Share Link Test";
      final secureShareLink = await client1.secureShareData(
        [file1, file2],
        [userId2],
        securitySettings: SecuritySettings(
          isPersistentProtected: true,
          isWatermarkEnabled: true,
          expirationDate: DateTime.now().add(const Duration(days: 10)),
        ),
        openMessage: openMessageText,
        encryptedMessage: encryptedMessageText,
      );
      expect(secureShareLink, isNotEmpty);
      final secureShareResult =
          await client2.decryptSecureShareLink(secureShareLink);
      debugPrint("Unencrypted Message: '${secureShareResult.openMessage}'");
      debugPrint("Encrypted Message: '${secureShareResult.encryptedMessage}'");
      debugPrint("Files Owner: '${secureShareResult.filesOwner}'");
      debugPrint("Files:");
      for (var file in secureShareResult.files) {
        debugPrint("\tFile PolicyId: '${file.policyId}'");
        debugPrint("\tFile Name: '${file.name}'");
        debugPrint("\tFile Size: ${file.size}");
        debugPrint("\tFile RCA Link: ${file.rcaLink}");
        debugPrint("\t====================");
      }
      expect(secureShareResult, isNotNull);
      expect(secureShareResult.files, hasLength(2));
      expect(secureShareResult.files[0].name, file1.name);
      expect(secureShareResult.files[1].name, file2.name);
      expect(secureShareResult.files[0].size, await file1.length());
      expect(secureShareResult.files[1].size, await file2.length());
      expect(secureShareResult.files[0].rcaLink, isNotEmpty);
      expect(secureShareResult.files[1].rcaLink, isNotEmpty);
      expect(secureShareResult.openMessage, openMessageText);
      expect(secureShareResult.encryptedMessage, encryptedMessageText);
      expect(secureShareResult.filesOwner, userId1);
    });
  });

  group("Encrypt/Decrypt Strings:", () {
    setUp(() => initAppIdClients(userId1, appId1, userId2, appId2));
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

      final policyId = encryptedResult.policyId;
      final policy = await client1.fetchPolicyById(policyId);
      final isPersistentProtected = policy.isPersistentProtectionEnabled();
      expect(isPersistentProtected, equals(true));
      policy.dispose();

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

      final policyId = encryptedResult.policyId;
      final policy = await client2.fetchPolicyById(policyId);
      final isWatermarkEnabled = policy.isWatermarkEnabled();
      expect(isWatermarkEnabled, equals(true));
      policy.dispose();

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
    }, timeout: const Timeout.factor(2));

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
      await stringToTdfToString();
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
      expect(sharedUsers, unorderedEquals([userId2, userId1]));
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
      final shareWith = [userId2];

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

      final actualOwner = policy.getOwner();
      expect(actualOwner, equals(userId1));

      final actualExpiration = policy.getExpirationDate();
      expect(actualExpiration!.difference(expiration).inSeconds, equals(0));

      final actualCopyEnabled = policy.isCopyEnabled();
      expect(actualCopyEnabled, equals(copy));

      final actualPrintEnabled = policy.isPrintEnabled();
      expect(actualPrintEnabled, equals(print));

      final actualReshareEnabled = policy.isReshareEnabled();
      expect(actualReshareEnabled, equals(reshare));

      final actualPersistentProtectionEnabled =
          policy.isPersistentProtectionEnabled();
      expect(actualPersistentProtectionEnabled, equals(persistentProtection));

      final actualWatermarkEnabled = policy.isWatermarkEnabled();
      expect(actualWatermarkEnabled, equals(watermark));

      final actualPreventDownloadEnabled = policy.isPreventDownloadEnabled();
      expect(actualPreventDownloadEnabled, equals(preventDownload));

      final actualSharedUsers = policy.getSharedUsers();
      final expectedSharedUsers = List<String>.from(shareWith)..add(userId1);
      expect(actualSharedUsers, unorderedEquals(expectedSharedUsers));

      policy.dispose();
    });

    test("TDF3 - Persistent Protection Enabled", () async {
      const testData = "TDF3 - Persistent Protection Enabled";
      final encryptedResult = await client2.encryptString(
        EncryptStringParams(testData)
          ..setDisplayName("$testData.txt")
          ..setDisplayMessage(_displayMessage(testData))
          ..setMimeType(ContentType.text.mimeType)
          ..setPolicy(
            Policy()
              ..setPersistentProtectionEnabled(true)
              ..shareWithUsers([userId1]),
          ),
      );

      final policyId = encryptedResult.policyId;
      final policy = await client2.fetchPolicyById(policyId);
      final isPersistentProtected = policy.isPersistentProtectionEnabled();
      expect(isPersistentProtected, equals(true));
      policy.dispose();

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

      final policyId = encryptedResult.policyId;
      final policy = await client1.fetchPolicyById(policyId);
      final isWatermarkEnabled = policy.isWatermarkEnabled();
      expect(isWatermarkEnabled, equals(true));
      policy.dispose();

      final tdf3String = encryptedResult.result;
      final decryptString = client2.decryptString(tdf3String);
      await expectLater(decryptString, throwsA(isA<NativeError>()));
    });

    test("TDF3 - Prevent Download", () async {
      const testData = "TDF3 - Prevent Download";
      final encryptedResult = await client2.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers([userId1])
          ..setDisplayName("$testData.txt")
          ..setDisplayMessage(_displayMessage(testData))
          ..setMimeType(ContentType.text.mimeType)
          ..setPolicy(
            Policy()..setPreventDownloadEnabled(true),
          ),
      );

      final policyId = encryptedResult.policyId;
      final policy = await client2.fetchPolicyById(policyId);
      final isPreventDownloadEnabled = policy.isPreventDownloadEnabled();
      expect(isPreventDownloadEnabled, equals(true));
      policy.dispose();

      final tdf3String = encryptedResult.result;
      final decryptString = client1.decryptString(tdf3String);
      await expectLater(decryptString, throwsA(isA<NativeError>()));
    });

    test("TDF3 - Copy, Print, Reshare", () async {
      const testData = "TDF3 - Copy, Print, Reshare";
      final copy = Random().nextBool();
      final print = Random().nextBool();
      final reshare = Random().nextBool();
      final encryptedResult = await client1.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers([userId2])
          ..setDisplayName("$testData.txt")
          ..setDisplayMessage(_displayMessage(testData))
          ..setMimeType(ContentType.text.mimeType)
          ..setPolicy(
            Policy()
              ..setCopyEnabled(copy)
              ..setPrintEnabled(print)
              ..setReshareEnabled(reshare),
          ),
      );

      final policyId = encryptedResult.policyId;
      final policy = await client1.fetchPolicyById(policyId);
      final isCopyEnabled = policy.isCopyEnabled();
      expect(isCopyEnabled, equals(copy));

      final isPrintEnabled = policy.isPrintEnabled();
      expect(isPrintEnabled, equals(print));

      final isReshareEnabled = policy.isReshareEnabled();
      expect(isReshareEnabled, equals(reshare));

      policy.dispose();
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
    }, timeout: const Timeout.factor(2));

    test("TDF3 - Set Expiration In Days", () async {
      const testData = "TDF3 - Set Expiration In Days";
      final expirationDays = Random().nextInt(100);
      final encryptedResult = await client2.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers([userId1])
          ..setDisplayName("$testData.txt")
          ..setDisplayMessage(_displayMessage(testData))
          ..setMimeType(ContentType.text.mimeType)
          ..setPolicy(
            Policy()..setExpirationInDays(expirationDays),
          ),
      );
      final policy = await client2.fetchPolicyById(encryptedResult.policyId);
      final expirationDate = policy.getExpirationDate();
      final expectedExpirationDate =
          DateTime.now().add(Duration(days: expirationDays));
      expect(expirationDate!.difference(expectedExpirationDate).inMinutes,
          equals(0));
      policy.dispose();
    });

    test("TDF3 - Set Expiration In Minutes", () async {
      const testData = "TDF3 - Set Expiration In Minutes";
      final expirationMinutes = Random().nextInt(1000);
      final encryptedResult = await client1.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers([userId2])
          ..setDisplayName("$testData.txt")
          ..setDisplayMessage(_displayMessage(testData))
          ..setMimeType(ContentType.text.mimeType)
          ..setPolicy(
            Policy()..setExpirationInMinutes(expirationMinutes),
          ),
      );
      final policy = await client1.fetchPolicyById(encryptedResult.policyId);
      final expirationDate = policy.getExpirationDate();
      final expectedExpirationDate =
          DateTime.now().add(Duration(minutes: expirationMinutes));
      expect(expirationDate!.difference(expectedExpirationDate).inMinutes,
          equals(0));
      policy.dispose();
    });

    test("TDF3 - Share With", () async {
      const testData = "TDF3 - Share With";
      final shareWith = [userId2];
      final encryptedResult = await client1.encryptString(
        EncryptStringParams(testData)
          ..shareWithUsers(shareWith)
          ..setDisplayName("$testData.txt")
          ..setMimeType(ContentType.text.mimeType)
          ..setDisplayMessage(_displayMessage(testData)),
      );

      final policy = await client1.fetchPolicyById(encryptedResult.policyId);
      final sharedWith = policy.getSharedUsers();
      final expectedSharedUsers = List<String>.from(shareWith)..add(userId1);
      expect(sharedWith, unorderedEquals(expectedSharedUsers));
      policy.dispose();
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
    setUp(() => initAppIdClients(userId1, appId1, userId2, appId2));
    tearDown(disposeAppIdClients);

    test("File -> RCA -> File", () async {
      const inputFilePath = "test_data/flutter.png";
      final inputFile = XFile(inputFilePath);
      final encryptedResult = await client1.encryptFileToRCA(
        EncryptFileToRcaParams(inputFile)
          ..setDisplayName("File -> RCA -> File")
          ..setDisplayMessage(_displayMessage("File -> RCA -> File"))
          ..setMimeType("image/png")
          ..shareWithUsers([userId2]),
      );
      final rcaLink = encryptedResult.result;
      const decryptedFilePath = "test_data/flutter_decrypted.png";
      final decryptedFile =
          await client2.decryptRcaToFile(rcaLink, XFile(decryptedFilePath));
      final actualBytes = await decryptedFile.readAsBytes();
      final expectedBytes = await inputFile.readAsBytes();
      expect(actualBytes, equals(expectedBytes));
      await decryptedFile.deleteIfExists();
    });

    test("RCA - Watermark Enabled", () async {
      const inputFilePath = "test_data/flutter.png";
      final inputFile = XFile(inputFilePath);
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

      final policyId = encryptedResult.policyId;
      final policy = await client1.fetchPolicyById(policyId);
      final isWatermarkEnabled = policy.isWatermarkEnabled();
      expect(isWatermarkEnabled, equals(true));
      policy.dispose();

      final rcaLink = encryptedResult.result;
      const decryptedFilePath = "test_data/flutter_decrypted.png";
      final decryptedFile = XFile(decryptedFilePath);
      final decryptRcaToFile = client2.decryptRcaToFile(rcaLink, decryptedFile);
      await expectLater(decryptRcaToFile, throwsA(isA<NativeError>()));
      await decryptedFile.deleteIfExists();
    });

    test("RCA - Remove Users", () async {
      const inputFilePath = "test_data/flutter.png";
      final inputFile = XFile(inputFilePath);
      final encryptedResult = await client2.encryptFileToRCA(
        EncryptFileToRcaParams(inputFile)
          ..setDisplayName("RCA - Remove Users")
          ..setDisplayMessage(_displayMessage("RCA - Remove Users"))
          ..setMimeType("image/png")
          ..shareWithUsers([userId1]),
      );
      final rcaLink = encryptedResult.result;
      const decryptedFilePath = "test_data/flutter_decrypted.png";
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

      await decryptedFile.deleteIfExists();
    });

    test("RCA - Revoke Access", () async {
      const inputFilePath = "test_data/sensitive.txt";
      final inputFile = XFile(inputFilePath);
      final encryptedResult = await client1.encryptFileToRCA(
        EncryptFileToRcaParams(inputFile)
          ..setDisplayName("RCA - Revoke Access")
          ..setDisplayMessage(_displayMessage("RCA - Revoke Access"))
          ..setMimeType(ContentType.text.mimeType)
          ..shareWithUsers([userId2]),
      );
      final rcaLink = encryptedResult.result;
      const decryptedFilePath = "test_data/sensitive_decrypted.txt";
      final decryptedFile =
          await client2.decryptRcaToFile(rcaLink, XFile(decryptedFilePath));
      final actualBytes = await decryptedFile.readAsBytes();
      final expectedBytes = await inputFile.readAsBytes();
      expect(actualBytes, equals(expectedBytes));

      client1.revokePolicy(encryptedResult.policyId);

      final decryptRcaToFile =
          client2.decryptRcaToFile(rcaLink, XFile(decryptedFilePath));
      await expectLater(decryptRcaToFile, throwsA(isA<NativeError>()));

      await decryptedFile.deleteIfExists();
    });

    test("RCA - Wrong Recipient", () async {
      const inputFilePath = "test_data/sensitive.txt";
      final inputFile = XFile(inputFilePath);
      final encryptFileToRCA =
          client2.encryptFileToRCA(EncryptFileToRcaParams(inputFile)
            ..shareWithUsers(["fake_user_email"])
            ..setDisplayName("RCA - Wrong Recipient")
            ..setDisplayMessage(_displayMessage("RCA - Wrong Recipient"))
            ..setMimeType(ContentType.text.mimeType));
      await expectLater(encryptFileToRCA, throwsA(isA<NativeError>()));
    });

    test("File -> TDF3 -> File", () async {
      const inputFilePath = "test_data/flutter.png";
      final inputFile = XFile(inputFilePath);
      const outputFilePath = "test_data/flutter.png.tdf.html";
      final encryptedResult = await client2.encryptFile(
        EncryptFileToFileParams(inputFile, XFile(outputFilePath))
          ..setDisplayName("File -> TDF3 -> File")
          ..setDisplayMessage(_displayMessage("File -> TDF3 -> File"))
          ..setMimeType("image/png")
          ..shareWithUsers([userId1]),
      );
      final encryptedFile = encryptedResult.result;
      const decryptedFilePath = "test_data/flutter_decrypted.png";
      final decryptedFile =
          await client1.decryptFile(encryptedFile, XFile(decryptedFilePath));
      final actualBytes = await decryptedFile.readAsBytes();
      final expectedBytes = await inputFile.readAsBytes();
      expect(actualBytes, equals(expectedBytes));
      await encryptedFile.deleteIfExists();
      await decryptedFile.deleteIfExists();
    });

    test("File - Watermark Enabled", () async {
      const inputFilePath = "test_data/flutter.png";
      final inputFile = XFile(inputFilePath);
      const outputFilePath = "test_data/flutter.png.tdf.html";
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

      final policyId = encryptedResult.policyId;
      final policy = await client1.fetchPolicyById(policyId);
      final isWatermarkEnabled = policy.isWatermarkEnabled();
      expect(isWatermarkEnabled, equals(true));
      policy.dispose();

      final encryptedFile = encryptedResult.result;
      final decryptedFile = XFile("test_data/flutter_decrypted.png");
      final decryptFile = client1.decryptFile(encryptedFile, decryptedFile);
      await expectLater(decryptFile, throwsA(isA<NativeError>()));
      await encryptedFile.deleteIfExists();
      await decryptedFile.deleteIfExists();
    });

    test("File -> ZIP -> File", () async {
      const inputFilePath = "test_data/sensitive.txt";
      final inputFile = XFile(inputFilePath);
      const outputFilePath = "test_data/sensitive.txt.tdf.zip";
      client1.setZipProtocol(true);
      final encryptedResult = await client1.encryptFile(
        EncryptFileToFileParams(inputFile, XFile(outputFilePath))
          ..setDisplayName("File -> ZIP -> File")
          ..setDisplayMessage(_displayMessage("File -> ZIP -> File"))
          ..setMimeType(ContentType.text.mimeType)
          ..shareWithUsers([userId2]),
      );
      final encryptedFile = encryptedResult.result;
      final extractedDir = Directory("encryptedFile");
      await extractFileToDisk(encryptedFile.path, extractedDir.path);
      final filesInDir = extractedDir.listSync().map((e) => XFile(e.path).name);
      expect(filesInDir, unorderedEquals(["0.manifest.json", "0.payload"]));
      const decryptedFilePath = "test_data/sensitive_decrypted.txt";
      final decryptedFile =
          await client2.decryptFile(encryptedFile, XFile(decryptedFilePath));
      final actualBytes = await decryptedFile.readAsBytes();
      final expectedBytes = await inputFile.readAsBytes();
      expect(actualBytes, equals(expectedBytes));
      await encryptedFile.deleteIfExists();
      await decryptedFile.deleteIfExists();
      await extractedDir.delete(recursive: true);
    });

    test("File - Remove Users", () async {
      const inputFilePath = "test_data/flutter.png";
      final inputFile = XFile(inputFilePath);
      const outputFilePath = "test_data/flutter.png.tdf.html";
      final encryptedResult = await client2.encryptFile(
        EncryptFileToFileParams(inputFile, XFile(outputFilePath))
          ..setDisplayName("File - Remove Users")
          ..setDisplayMessage(_displayMessage("File - Remove Users"))
          ..setMimeType("image/png")
          ..shareWithUsers([userId1]),
      );
      final encryptedFile = encryptedResult.result;
      const decryptedFilePath = "test_data/flutter_decrypted.png";
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

      await encryptedFile.deleteIfExists();
      await decryptedFile.deleteIfExists();
    });

    test("File - Revoke Access", () async {
      const inputFilePath = "test_data/sensitive.txt";
      final inputFile = XFile(inputFilePath);
      const outputFilePath = "test_data/sensitive.txt.tdf.html";
      final encryptedResult = await client2.encryptFile(
        EncryptFileToFileParams(inputFile, XFile(outputFilePath))
          ..setDisplayName("File - Revoke Access")
          ..setDisplayMessage(_displayMessage("File - Revoke Access"))
          ..setMimeType(ContentType.text.mimeType)
          ..shareWithUsers([userId1]),
      );
      final encryptedFile = encryptedResult.result;
      const decryptedFilePath = "test_data/sensitive_decrypted.txt";
      final decryptedFile =
          await client1.decryptFile(encryptedFile, XFile(decryptedFilePath));
      final actualBytes = await decryptedFile.readAsBytes();
      final expectedBytes = await inputFile.readAsBytes();
      expect(actualBytes, equals(expectedBytes));

      await client2.revokeFile(encryptedFile);

      final decryptFile =
          client1.decryptFile(encryptedFile, XFile(decryptedFilePath));
      await expectLater(decryptFile, throwsA(isA<NativeError>()));

      await encryptedFile.deleteIfExists();
      await decryptedFile.deleteIfExists();
    });

    test("File - Wrong Recipient", () async {
      const inputFilePath = "test_data/flutter.png";
      final inputFile = XFile(inputFilePath);
      const outputFilePath = "test_data/flutter.png.tdf.html";
      final outputFile = XFile(outputFilePath);
      final encryptFile =
          client1.encryptFile(EncryptFileToFileParams(inputFile, outputFile)
            ..shareWithUsers(["fake_user_email"])
            ..setDisplayName("File - Wrong Recipient")
            ..setDisplayMessage(_displayMessage("File - Wrong Recipient"))
            ..setMimeType("image/png"));
      await expectLater(encryptFile, throwsA(isA<NativeError>()));
      await outputFile.deleteIfExists();
    });
  });
}

_displayMessage(String testName) => "Flutter SDK test: '$testName'";

extension Delete on XFile {
  deleteIfExists() async {
    if (!kIsWeb) {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    }
  }
}
