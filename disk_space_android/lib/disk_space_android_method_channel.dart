import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'disk_space_android_platform_interface.dart';

/// An implementation of [DiskSpaceAndroidPlatform] that uses method channels.
class MethodChannelDiskSpaceAndroid extends DiskSpaceAndroidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('disk_space_android');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
