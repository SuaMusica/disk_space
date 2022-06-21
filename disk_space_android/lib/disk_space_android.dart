
import 'disk_space_android_platform_interface.dart';

class DiskSpaceAndroid {
  Future<String?> getPlatformVersion() {
    return DiskSpaceAndroidPlatform.instance.getPlatformVersion();
  }
}
