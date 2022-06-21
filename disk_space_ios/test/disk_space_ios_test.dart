import 'package:flutter_test/flutter_test.dart';
import 'package:disk_space_ios/disk_space_ios.dart';
import 'package:disk_space_ios/disk_space_ios_platform_interface.dart';
import 'package:disk_space_ios/disk_space_ios_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDiskSpaceIosPlatform 
    with MockPlatformInterfaceMixin
    implements DiskSpaceIosPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DiskSpaceIosPlatform initialPlatform = DiskSpaceIosPlatform.instance;

  test('$MethodChannelDiskSpaceIos is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDiskSpaceIos>());
  });

  test('getPlatformVersion', () async {
    DiskSpaceIos diskSpaceIosPlugin = DiskSpaceIos();
    MockDiskSpaceIosPlatform fakePlatform = MockDiskSpaceIosPlatform();
    DiskSpaceIosPlatform.instance = fakePlatform;
  
    expect(await diskSpaceIosPlugin.getPlatformVersion(), '42');
  });
}
