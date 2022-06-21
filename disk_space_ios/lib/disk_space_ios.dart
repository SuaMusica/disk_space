
import 'disk_space_ios_platform_interface.dart';

class DiskSpaceIos {
  Future<String?> getPlatformVersion() {
    return DiskSpaceIosPlatform.instance.getPlatformVersion();
  }
}
