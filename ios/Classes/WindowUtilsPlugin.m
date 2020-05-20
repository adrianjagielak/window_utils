#import "WindowUtilsPlugin.h"
#if __has_include(<window_utils/window_utils-Swift.h>)
#import <window_utils/window_utils-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "window_utils-Swift.h"
#endif

@implementation WindowUtilsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWindowUtilsPlugin registerWithRegistrar:registrar];
}
@end
