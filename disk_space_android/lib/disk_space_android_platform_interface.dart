import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'disk_space_android_method_channel.dart';

abstract class DiskSpaceAndroidPlatform extends PlatformInterface {
  /// Constructs a DiskSpaceAndroidPlatform.
  DiskSpaceAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static DiskSpaceAndroidPlatform _instance = MethodChannelDiskSpaceAndroid();

  /// The default instance of [DiskSpaceAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelDiskSpaceAndroid].
  static DiskSpaceAndroidPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DiskSpaceAndroidPlatform] when
  /// they register themselves.
  static set instance(DiskSpaceAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
