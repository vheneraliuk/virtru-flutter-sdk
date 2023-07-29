import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_flutter.dart';

final userId1 = Platform.environment["TEST_USER_ID_1"]!;
final appId1 = Platform.environment["TEST_APP_ID_1"]!;
final userId2 = Platform.environment["TEST_USER_ID_2"]!;
final appId2 = Platform.environment["TEST_APP_ID_2"]!;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Client client1;
  late Client client2;

  setUpAll(() {
    client1 = Client.withAppId(userId: userId1, appId: appId1);
    client2 = Client.withAppId(userId: userId2, appId: appId2);
  });

  test("Wrong AppID and UserId", () async {
    const testData = "Wrong AppID and UserId";
    final client =
        Client.withAppId(userId: "fake@user.id", appId: "fake_app_id");
    final shouldThrowError =
        client.encryptString(EncryptStringParams(testData));
    await expectLater(shouldThrowError, throwsA(isA<NativeError>()));
    client.dispose();
  });

  group("Encrypt/Decrypt Strings:", () {
    test("String -> RCA -> String", () async {
      const testData = "String -> RCA -> String";
      final rcaLink = await client1.encryptStringToRCA(
        EncryptStringParams(testData)..shareWithUsers([userId2]),
      );
      final decryptedText = await client2.decryptRcaToString(rcaLink);
      expect(testData, equals(decryptedText));
    });

    test("String -> TDF3 -> String", () async {
      const testData = "String -> TDF3 -> String";
      debugPrint(testData);
      // final expected = String.fromCharCodes(testData.codeUnits);
      final tdf3String = await client2.encryptString(
        EncryptStringParams(testData)..shareWithUsers([userId1]),
      );
      debugPrint(testData);
      final decryptedText = await client1.decryptString(tdf3String);
      debugPrint(testData);
      expect(testData, equals(decryptedText));
      debugPrint(testData);
    });
  });

  group("Encrypt/Decrypt Files:", () {
    test("File -> RCA -> File", () async {
      final bytes = await rootBundle.load("assets/flutter.png");
      const inputFilePath = "flutter.png";
      final inputFile = XFile.fromData(
        bytes.buffer.asUint8List(),
        path: inputFilePath,
      );
      await inputFile.saveTo(inputFilePath);
      final rcaLink = await client1.encryptFileToRCA(
        EncryptFileToRcaParams(inputFile)..shareWithUsers([userId2]),
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

    test("File -> File -> File", () async {
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
          ..shareWithUsers([userId2]),
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
    });
  });

  tearDownAll(() {
    client1.dispose();
    client2.dispose();
  });
}

extension Delete on XFile {
  delete() async {
    if (!kIsWeb) {
      await File(path).delete();
    }
  }
}
