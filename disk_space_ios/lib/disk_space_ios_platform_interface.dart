import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'disk_space_ios_method_channel.dart';

abstract class DiskSpaceIosPlatform extends PlatformInterface {
  /// Constructs a DiskSpaceIosPlatform.
  DiskSpaceIosPlatform() : super(token: _token);

  static final Object _token = Object();

  static DiskSpaceIosPlatform _instance = MethodChannelDiskSpaceIos();

  /// The default instance of [DiskSpaceIosPlatform] to use.
  ///
  /// Defaults to [MethodChannelDiskSpaceIos].
  static DiskSpaceIosPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DiskSpaceIosPlatform] when
  /// they register themselves.
  static set instance(DiskSpaceIosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
