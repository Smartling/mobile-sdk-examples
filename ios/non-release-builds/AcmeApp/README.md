# Smartling Framework Non-Release Only

This application uses the Smarting SDK for In-App Review and/or Context Capture.
The developer does not want to ship the Smartling SDK with release builds.

To accomplish this, we configure the Xcode workspace to:

1. Only link the Smartling SDK in Debug builds
2. Use or define compiler flags for debug vs release builds
3. Use these conditionals to import and initialize the SDK

## Only Link the Smartling SDK in Debug builds

This can be handled manually in Xcode, or preferably, using CocoaPods or Carthange's
configuration options. For example, with CocoaPods we set up our Podfile:

```
target 'MyApp' do
  pod 'Smartling-framework', :configurations => ['Debug'] 
end
```
[See the full podfile][Podfile]

## Compiler Flags

### Objective-C

In Objective-C, the `DEBUG` flag is already defined as a preprocessor macro.

In our code, we can use following marcros:

```
#ifdef DEBUG
// debug only code
#else
// release only code
#endif
```

### Swift

In Swift, you have to update the project settings. Open your Project Build Settings
and search for "Swift Compiler - Custom Flags" ... "Other Swift Flags". In the "Debug"
section, add `-DDEBUG

In our code, we can now use the macros:

```
#if DEBUG
// debug only code
#else
// release only code
#endif
```

## Use conditionals to handle the Smartling SDK

In our App delegate, we conditionally initialize the Smartling SDK:

```
#import "AppDelegate.h"
#if DEBUG
#import "Smartling/Smartling.h"
#endif

@interface AppDelegate ()
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#if DEBUG
    [Smartling startWithProjectId:@"ac3ff4ee2" andOptions:@{SLLogging : SLLoggingDebug, SLMode: SLInAppReview}];
#endif
    return YES;
}
@end
```

## Running the Demo

You can clone this repository and run the AcmeApp. In debug mode, the Smartling In-App Review feature will be
available.

Edit the build scheme and change the build configuration from "Debug" to "Release".
Run the application again, note that the conditionals we used still allow the App to compile without the
Smartling SDK being linked. In this configuration, the Smartling SDK is not present in the built application.

[Podfile]: https://github.com/Smartling/mobile-sdk-examples/blob/master/ios/non-release-builds/AcmeApp/Podfile
