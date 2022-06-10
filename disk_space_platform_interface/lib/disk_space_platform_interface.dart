import 'package:disk_space_platform_interface/disk_space_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class DiskSpacePlatform extends PlatformInterface {
  /// Constructs a DiskSpaceAndroidPlatform.
  DiskSpacePlatform() : super(token: _token);

  static final Object _token = Object();

  static DiskSpacePlatform _instance = MethodChannelDiskSpace();

  /// The default instance of [DiskSpacePlatform] to use.
  ///
  /// Defaults to [MethodChannelDiskSpaceAndroid].
  static DiskSpacePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DiskSpacePlatform] when
  /// they register themselves.
  static set instance(DiskSpacePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
