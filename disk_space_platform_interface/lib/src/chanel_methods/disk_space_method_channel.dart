import 'package:disk_space_platform_interface/src/disk_space_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// An implementation of [DiskSpacePlatform] that uses method channels.
class MethodChannelDiskSpace extends DiskSpacePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel =
      const MethodChannel('plugins.suamusica.com.br/disk_space');

  @override
  Future<String?> platformVersion() async {
    final version = await methodChannel.invokeMethod<String>('platformVersion');
    return version;
  }

  @override
  Future<double?> getFreeDiskSpace() async {
    final double? freeDiskSpace =
        await methodChannel.invokeMethod('getFreeDiskSpace');
    return freeDiskSpace;
  }

  @override
  Future<double?> getTotalDiskSpace() async {
    final double? totalDiskSpace =
        await methodChannel.invokeMethod('getTotalDiskSpace');
    return totalDiskSpace;
  }
}
