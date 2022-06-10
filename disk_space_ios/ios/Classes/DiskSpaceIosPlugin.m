#import "DiskSpaceIosPlugin.h"
#if __has_include(<disk_space_ios/disk_space_ios-Swift.h>)
#import <disk_space_ios/disk_space_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "disk_space_ios-Swift.h"
#endif

@implementation DiskSpaceIosPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDiskSpaceIosPlugin registerWithRegistrar:registrar];
}
@end
