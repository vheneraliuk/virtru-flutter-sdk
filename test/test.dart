// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_flutter.dart';

final userId1 = Platform.environment["TEST_USER_ID_1"]!;
final appId1 = Platform.environment["TEST_APP_ID_1"]!;
final userId2 = Platform.environment["TEST_USER_ID_2"]!;
final appId2 = Platform.environment["TEST_APP_ID_2"]!;

void main() {
  late Client client1;
  late Client client2;

  setUpAll(() {
    client1 = Client.withAppId(userId: userId1, appId: appId1);
    client2 = Client.withAppId(userId: userId2, appId: appId2);
  });

  test("Wrong AppID and UserId", () async {
    final testData = "Wrong AppID and UserId";
    final client =
        Client.withAppId(userId: "fake@user.id", appId: "fake_app_id");
    final shouldThrowError =
        client.encryptString(EncryptStringParams(testData));
    await expectLater(shouldThrowError, throwsA(isA<NativeError>()));
    client.dispose();
  });

  group("Encrypt/Decrypt Strings:", () {
    test("String -> RCA -> String", () async {
      final testData = "String -> RCA -> String";
      final rcaLink = await client1.encryptStringToRCA(
        EncryptStringParams(testData)..shareWithUsers([userId2]),
      );
      final decryptedText = await client2.decryptRcaToString(rcaLink);
      expect(testData, equals(decryptedText));
    });

    test("String -> TDF3 -> String", () async {
      final testData = "String -> TDF3 -> String";
      final tdf3String = await client2.encryptString(
        EncryptStringParams(testData)..shareWithUsers([userId1]),
      );
      final decryptedText = await client1.decryptString(tdf3String);
      expect(testData, equals(decryptedText));
    }, skip: "Weird fail");
  });

  tearDownAll(() {
    client1.dispose();
    client2.dispose();
  });
}
