import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_openvpn/flutter_openvpn.dart';
import 'package:flutter_openvpn_example/newPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static Future<void> initPlatformState() async {
    await FlutterOpenvpn.lunchVpn(
      ovpnFileContents: '''

      ''',
      onProfileStatusChanged: (isProfileLoaded) {
        print('isProfileLoaded : $isProfileLoaded');
      },
      onVPNStatusChanged: (vpnActivated) {
        print('vpnActivated : $vpnActivated');
      },
      user: '',
      pass: '',
      onConnectionStatusChanged:
          (duration, lastPacketReceive, byteIn, byteOut) =>
              print('BYTE IN : $byteIn'),
      connectionId: "superman",
      connectionName: "xxx",
      timeOut: Duration(seconds: 5),
      expireAt: DateTime.now().add(
        Duration(
          seconds: 180,
        ),
      ),
    );
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => NewPAge(
              settings.name.contains(NewPAge.subPath)
                  ? settings.name.split(NewPAge.subPath)[1]
                  : '0',
              settings.name.split(NewPAge.subPath)[1].compareTo('2') < 0),
          settings: settings),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: NewPAge('0', true),
      ),
    );
  }
}
