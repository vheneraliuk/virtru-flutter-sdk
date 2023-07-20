import 'dart:async';

import 'package:flutter/material.dart';
import 'package:virtru_sdk_flutter/virtru_sdk_flutter.dart' as virtru;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late virtru.Client client;

  @override
  void initState() {
    super.initState();
    client = virtru.Client.withAppId(appId: "", userId: "");
    client.enableConsoleLogging();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    const spacerSmall = SizedBox(height: 10);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  'This calls a native function through FFI that is shipped as source in the package. '
                  'The native code is built as part of the Flutter Runner build.',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                const Text(
                  'sum(1, 2) = No result',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                FutureBuilder<String>(
                  future: _encryptFuture(),
                  initialData: "Loading...",
                  builder: (BuildContext context, AsyncSnapshot<String> value) {
                    final displayValue =
                        (value.hasData) ? value.data : 'Nothing here';
                    return Text(
                      'await encryptResult = $displayValue',
                      style: textStyle,
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _encryptFuture() async {
    debugPrint("_encryptFuture() called!");
    final params = virtru.EncryptStringParams("Some secure text")
        .setPolicy(virtru.Policy())
        .shareWithUsers(["vhereliuk.ctr@virtru.com"]);
    debugPrint("Policy added!");
    return client.encryptString(params);
  }
}
