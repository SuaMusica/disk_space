import 'package:flutter_test/flutter_test.dart';
import 'package:disk_space_android/disk_space_android.dart';
import 'package:disk_space_android/disk_space_android_platform_interface.dart';
import 'package:disk_space_android/disk_space_android_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDiskSpaceAndroidPlatform 
    with MockPlatformInterfaceMixin
    implements DiskSpaceAndroidPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DiskSpaceAndroidPlatform initialPlatform = DiskSpaceAndroidPlatform.instance;

  test('$MethodChannelDiskSpaceAndroid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDiskSpaceAndroid>());
  });

  test('getPlatformVersion', () async {
    DiskSpaceAndroid diskSpaceAndroidPlugin = DiskSpaceAndroid();
    MockDiskSpaceAndroidPlatform fakePlatform = MockDiskSpaceAndroidPlatform();
    DiskSpaceAndroidPlatform.instance = fakePlatform;
  
    expect(await diskSpaceAndroidPlugin.getPlatformVersion(), '42');
  });
}
