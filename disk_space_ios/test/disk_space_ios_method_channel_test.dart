import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:disk_space_ios/disk_space_ios_method_channel.dart';

void main() {
  MethodChannelDiskSpaceIos platform = MethodChannelDiskSpaceIos();
  const MethodChannel channel = MethodChannel('disk_space_ios');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
