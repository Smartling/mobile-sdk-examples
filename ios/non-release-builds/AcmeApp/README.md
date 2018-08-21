# Smartling Framework Non-Release Only

This application uses the Smarting SDK for In-App Review and/or Context Capture.
The developer does not want to ship the Smartling SDK with release builds.

To accomplish this, we configure the Xcode workspace to:

1. Only link the Smartling SDK in Debug builds
2. Use or define compiler flags for debug vs release builds
3. Use these conditionals to import and initialize the SDK

## Only Link the Smartling SDK in Debug builds

The can be handled manually in Xcode, or preferably, using CocoaPods or Carthange's
 configuration options. For example, with CocoaPods we set up our Podfile:

```
target 'MyApp' do
  pod 'Smartling-framework', :configurations => ['Debug'] 
end
```
[See the full podfile][Podfile]


[Podfile]: https://github.com/Smartling/mobile-sdk-examples/blob/master/ios/non-release-builds/AcmeApp/Podfile
