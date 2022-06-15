import 'dart:io';

import 'package:disk_space/disk_space.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  double? _diskSpace = 0;
  double? _totalSpace = 0;
  double? _sdSpace = 0;
  bool _hasSd = false;

  bool get isAndroid => Platform.isAndroid;

  @override
  void initState() {
    super.initState();
    initDiskSpace();
    totalDiskSpace();
    if (isAndroid) {
      sdSpace();
      hasSd();
    }
  }

  Future<void> initDiskSpace() async {
    final diskSpace = await DiskSpace.getFreeDiskSpace();

    if (!mounted) return;

    setState(() {
      _diskSpace = diskSpace;
    });
  }

  Future<void> sdSpace() async {
    final sdSpace = await DiskSpace.getFreeSdSpace();

    if (!mounted) return;

    setState(() {
      _sdSpace = sdSpace;
    });
  }

  Future<void> hasSd() async {
    final hasSd = await DiskSpace.hasSdCard();

    if (!mounted) return;

    setState(() {
      _hasSd = hasSd;
    });
  }

  Future<void> totalDiskSpace() async {
    final totalSpace = await DiskSpace.getTotalDiskSpace();

    if (!mounted) return;

    setState(() {
      _totalSpace = totalSpace;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('Free Space on device (MB): $_diskSpace\n'),
            ),
            Center(
              child: Text('Total Space on device (MB): $_totalSpace\n'),
            ),
            if (isAndroid)
              Column(
                children: [
                  Center(
                    child: Text('Has SD: $_hasSd\n'),
                  ),
                  Center(
                    child: Text('SD Space on device (MB): $_sdSpace\n'),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
