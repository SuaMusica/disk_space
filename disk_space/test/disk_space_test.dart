import 'package:disk_space_platform_interface/disk_space_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MethodChannelDiskSpace platform = MethodChannelDiskSpace();
  const MethodChannel channel =
      MethodChannel('plugins.suamusica.com.br/disk_space');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'platformVersion') {
        return '42';
      } else if (methodCall.method == 'hasSdCard') {
        return false;
      } else {
        return 42.0;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(
      await platform.platformVersion(),
      '42',
    );
  });

  test('getFreeDiskSpace', () async {
    expect(
      await platform.getFreeDiskSpace(),
      42,
    );
  });

  test('getTotalDiskSpace', () async {
    expect(await platform.getTotalDiskSpace(), 42);
  });

  test('getFreeSdSpace', () async {
    expect(
      await platform.getFreeSdSpace(),
      42,
    );
  });

  test('hasSdCard', () async {
    expect(
      await platform.hasSdCard(),
      false,
    );
  });
}
