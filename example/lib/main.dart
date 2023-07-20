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
  final rcaLink =
      "https://secure.virtru.com/start#v=4.0.0&pu=https%3A%2F%2Fapi.virtru.com%2Facm%2Fapi%2Fpolicies%2F139dee9b-4dcb-40e1-bf14-154e4155ff19%2Fcontract&wu=https%3A%2F%2Fapi.virtru.com%2Fencrypted-storage%2F0da80533-010a-4fa5-b8a4-97baa026798e.tdf&al=AES-256-GCM";
  String? result;

  @override
  void initState() {
    super.initState();
    client = virtru.Client.withAppId(appId: "", userId: "");
    _encryptFuture();
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
                Text(
                  'decryptRcaToString = $result',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _encryptFuture() async {
    debugPrint("_encryptFuture() called!");
    final params = virtru.EncryptStringParams("Some secure text")
      ..setPolicy(virtru.Policy())
      ..shareWithUsers(["vhereliuk.ctr@virtru.com"]);
    debugPrint("Policy added!");
    String result = await client.decryptRcaToString(rcaLink);
    setState(() {
      this.result = result;
    });
  }
}
