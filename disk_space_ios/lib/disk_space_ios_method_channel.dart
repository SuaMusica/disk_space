import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'disk_space_ios_platform_interface.dart';

/// An implementation of [DiskSpaceIosPlatform] that uses method channels.
class MethodChannelDiskSpaceIos extends DiskSpaceIosPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('disk_space_ios');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
