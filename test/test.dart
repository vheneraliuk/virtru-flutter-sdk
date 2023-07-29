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
const testData = "Flutter SDK unit tests secure message!";

void main() {
  test("Wrong AppID and UserId", () async {
    final client =
        Client.withAppId(userId: "fake@user.id", appId: "fake_app_id");
    final shouldThrowError =
        client.encryptString(EncryptStringParams(testData));
    await expectLater(shouldThrowError, throwsA(isA<NativeError>()));
    client.dispose();
  });

  test("String -> RCA -> String", () async {
    final client1 = Client.withAppId(userId: userId1, appId: appId1);
    final client2 = Client.withAppId(userId: userId2, appId: appId2);
    final rcaLink = await client1.encryptStringToRCA(
      EncryptStringParams(testData)..shareWithUsers([userId2]),
    );
    final decryptedText = await client2.decryptRcaToString(rcaLink);
    expect(testData, decryptedText);
    client1.dispose();
    client2.dispose();
  });

  test("String -> TDF3 -> String", () async {
    final client1 = Client.withAppId(userId: userId1, appId: appId1);
    final client2 = Client.withAppId(userId: userId2, appId: appId2);
    final tdf3String = await client2.encryptString(
      EncryptStringParams(testData)..shareWithUsers([userId1]),
    );
    final decryptedText = await client1.decryptString(tdf3String);
    expect(testData, decryptedText);
    client1.dispose();
    client2.dispose();
  });
}
