import 'package:disk_space_platform_interface/disk_space_platform_interface.dart';

class DiskSpace {
  static Future<String?> platformVersion() =>
      DiskSpacePlatform.instance.platformVersion();

  static Future<double?> getFreeDiskSpace() =>
      DiskSpacePlatform.instance.getFreeDiskSpace();

  static Future<double?> getTotalDiskSpace() =>
      DiskSpacePlatform.instance.getTotalDiskSpace();
}
