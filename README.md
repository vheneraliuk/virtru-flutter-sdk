# Virtru SDK for Flutter
[![Unit Tests](https://github.com/vheneraliuk/virtru-flutter-sdk/actions/workflows/test.yaml/badge.svg)](https://github.com/vheneraliuk/virtru-flutter-sdk/actions/workflows/test.yaml)

You’re Alice and you have sensitive data to protect. (Don’t we all?)

Let’s see the fastest way to protect it server-side with the Virtru SDK.

## Quick Start: Flutter

### Install the SDK

Just add to your `pubspec.yaml`:

```yaml
dependencies:
  virtru_sdk_flutter:
    git:
      url: https://github.com/vheneraliuk/virtru-flutter-sdk.git
      ref: main
```

# Get an identity

So Alice, who should own your sensitive data? You, obviously!

Authenticate to associate your email address (e.g. `alice@example.com`) with any data you protect. **You cannot protect data without authenticating.** If the Virtru Platform doesn’t know who’s protecting data, no one would be able to access it later (when they’re also asked to authenticate).

The fastest way to authenticate on the server side is with an appId token. You can generate one from the Virtru Dashboard. If you need help, see detailed steps.

For safekeeping, don’t hard code your appID anywhere.

To protect your sensitive data, we’ll need a Virtru client. We’ll associate anything you encrypt with your email and appId. Let’s make sure your email and appId can create a valid Virtru client to make further SDK calls:

```dart
import 'package:virtru_sdk_flutter/virtru_sdk_flutter.dart';

void main() async {
  const email = "alice@example.com";
  const appId = "APP_ID_FROM_DASHBOARD";

  final client = Client.withAppId(userId: email, appId: appId);

  print("Ready to protect!");
}
```

### Protect the sensitive data

Next, **decide your encryption options.** For now, it’s the file containing your sensitive data. In the future, this could include who else should have access and under what conditions.

```dart
  final inputFile = XFile("sensitive.txt");
  final outputFile = XFile("${inputFile.path}.tdf.html");
  final params = EncryptFileToFileParams(inputFile, outputFile);
```

Finally, encrypt the data:

```dart
  final encryptResult = await client.encryptFile(params);
```

Here is the complete source code:

```dart
import 'package:virtru_sdk_flutter/virtru_sdk_flutter.dart';

void main() async {
  const email = "alice@example.com";
  const appId = "APP_ID_FROM_DASHBOARD";

  final client = Client.withAppId(userId: email, appId: appId);

  final inputFile = XFile("sensitive.txt");
  final outputFile = XFile("${inputFile.path}.tdf.html");
  final params = EncryptFileToFileParams(inputFile, outputFile);

  final encryptResult = await client.encryptFile(params);

  final policyId = encryptResult.policyId;
  final protectedFile = encryptResult.result;

  print("PolicyID: $policyId");
  print("Encrypted file: ${ await protectedFile.readAsString()}");

  client.dispose();
}
```

### Access the sensitive data

Now, let’s say you need to see your sensitive data again. Authenticate as `alice@example.com` again and you can decrypt the protected file:

```dart
import 'package:virtru_sdk_flutter/virtru_sdk_flutter.dart';

void main() async {
  const email = "alice@example.com";
  const appId = "APP_ID_FROM_DASHBOARD";

  final client = Client.withAppId(userId: email, appId: appId);

  final inputFile = XFile("sensitive.txt.tdf.html");
  final outputFile = XFile("sensitive_decrypted.txt");

  final decryptedFile = await client.decryptFile(inputFile, outputFile);

  print("Decrypted file: ${await decryptedFile.readAsString()}");

  client.dispose();
}
```

The decrypted file should match your original one with the sensitive data.

### Access the sensitive data anywhere

If you inspect the generated HTML file, you still won’t find your sensitive data. It stays protected. You can send that HTML file to another machine or anywhere you want. Only you will be able to access it. But how do you do that outside of this code?

We could build a whole set of functionality to authenticate, decrypt, and render files. Or we could **use Virtru’s Secure Reader**, which is built to do exactly that for thousands of security-conscious users every day. In fact, if you open that HTML file from the last step, it will redirect you to Secure Reader.

Secure Reader will ask you to authenticate. (You’re still Alice, aren’t you?)

![Secure Reader](https://www.virtru.com/hubfs/Dev%20Docs/auth.png)

And if you authenticate with the same email address you used to create the HTML file, you should be able to view it in Secure Reader:

![Secure Reader](https://www.virtru.com/hubfs/Dev%20Docs/decrypt.png)

Congrats Alice! **Your sensitive data is safe wherever it goes.**

## Encryption

Now that the Virtru SDK knows you’re Alice, you can protect your first piece of data.

### Encryption Basics

Before calling encrypt, you need to specify a few simple parameters.

You don’t need to include your email address when encrypting. You will already have access to anything you encrypt because you authenticated. But if you want anyone else to have access (like another one of your emails, `alice@nowhere.com`), you could include them here:

```dart
  const sensitiveData = "sensitive data";
  final params = EncryptStringParams(sensitiveData)
    ..shareWithUsers(["alice@nowhere.com"]);
```

Call encrypt and check out the resulting file:

```dart
  final encryptedResult = await client.encryptString(params);

  final policyId = encryptedResult.policyId;
  final encryptedData = encryptedResult.result;

  print("PolicyId: $policyId");
  print("Encrypted data: $encryptedData");
```

Here's the complete source code:

```dart
import 'package:virtru_sdk_flutter/virtru_sdk_flutter.dart';

void main() async {
  const email = "alice@example.com";
  const appId = "APP_ID_FROM_DASHBOARD";

  final client = Client.withAppId(userId: email, appId: appId);

  const sensitiveData = "sensitive data";
  final params = EncryptStringParams(sensitiveData)
    ..shareWithUsers(["alice@nowhere.com"]);

  final encryptedResult = await client.encryptString(params);

  final policyId = encryptedResult.policyId;
  final encryptedData = encryptedResult.result;

  print("PolicyId: $policyId");
  print("Encrypted data: $encryptedData");

  client.dispose();
}
```

Now, your sensitive data is safe.
