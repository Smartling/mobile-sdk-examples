# Smartling SDK Non-Release Only

This application uses the Smarting SDK for In-App Review and/or Context Capture.
The developer does not want to ship the Smartling SDK with release builds.

1. Add the Smartling SDK as a Dependency
2. Configure the Smartling SDK

## Add the Smartling Plugin(s)

### Single Module Application

If your appliction contains only a single module, you can configure Smartling
by applying the plugin in your app's `build.gradle` by adding the Smartling
plugin after the Android plugin:

    apply plugin: 'com.android.application'
    apply plugin: 'com.smartling.android.application'

    smartling { ... }

The SDK configuration section can be added directly to the app module.

### Multi Module Applications

If you use multiple modules to build your application, you must configure the
Smartling SDK in the main `build.gradle` file. For each library module, add
the Smartling library plugin. For the application module - there can only be
one - add the Smartling application plugin.

Root build.gradle:

     apply plugin: 'com.smartling.android.config'

    smartling { ... }

Library module(s) build.grade:

    apply plugin: 'com.android.library'
    apply plugin: 'com.smartling.android.library'

App module build.gradle:

    apply plugin: 'com.android.application'
    apply plugin: 'com.smartling.android.application'

## Configure the Smartling SDK

The SDK mode can be configured by a build variable to enable or disable it for
a given build run:

```groovy
ext {
   SMARTLING_SDK_MODE = "in-app-review"
}

smartling {
    projectId = "deaf9496f"
    mode = SMARTLING_SDK_MODE
}
```
You can control this the same you update any build property at build time.

## Running the Demo

You can clone this repository and run the AcmeApp. In Android Studio, set the
main build file set `SMARTLING_SDK_MODE` to `in-app-review` and run the
application. The Smartling In-App Review feature will be available.

Change the `SMARTLING_SDK_MODE` to `disabled` and clean the build. Run the
application again, note that the App to compiles without the Smartling SDK
being linked. In this configuration, the Smartling SDK is not present in the
built application.

This can also be confirmed by running a build on the command line.

Assemble the App with SDK enabled:

```sh
➜  AcmeApp git:(multimodules) ✗ ./gradlew clean assemble

> Configure project :app
NO MATCH FOUND
Smartling: Add process manifest action to review-debug
Smartling: Add process manifest action to review-release
Smartling: Add process manifest action to full-debug
Smartling: Add process manifest action to full-release

> Configure project :common
Smartling pre-check mode: in-app-review

> Task :app:preFullDebugBuild
Smartling: adding deps
Smartling: adding deps

> Task :app:processFullDebugManifest
Smartling: Modified manifest at /home/scott/Development/mobile-sdk-examples/android/non-release-builds/AcmeApp/app/build/intermediates/manifests/full/full/debug/AndroidManifest.xml

> Task :app:processReviewDebugManifest
Smartling: Modified manifest at /home/scott/Development/mobile-sdk-examples/android/non-release-builds/AcmeApp/app/build/intermediates/manifests/full/review/debug/AndroidManifest.xml

> Task :app:processFullReleaseManifest
Smartling: Modified manifest at /home/scott/Development/mobile-sdk-examples/android/non-release-builds/AcmeApp/app/build/intermediates/manifests/full/full/release/AndroidManifest.xml

> Task :app:processReviewReleaseManifest
Smartling: Modified manifest at /home/scott/Development/mobile-sdk-examples/android/non-release-builds/AcmeApp/app/build/intermediates/manifests/full/review/release/AndroidManifest.xml

> Task :common:transformClassesWithSmartlingForFullDebug
Smartling: Applied SDK to com.smartling.demo.common.CommonActivity

> Task :app:transformClassesWithSmartlingForFullDebug
Smartling: Applied SDK to com.smartling.demo.acmeapp.MainActivity

> Task :common:transformClassesWithSmartlingForReviewDebug
Smartling: Applied SDK to com.smartling.demo.common.CommonActivity

> Task :app:transformClassesWithSmartlingForReviewDebug
Smartling: Applied SDK to com.smartling.demo.acmeapp.MainActivity

> Task :common:transformClassesWithSmartlingForFullRelease
Smartling: Applied SDK to com.smartling.demo.common.CommonActivity

> Task :app:transformClassesWithSmartlingForFullRelease
Smartling: Applied SDK to com.smartling.demo.acmeapp.MainActivity

> Task :common:transformClassesWithSmartlingForReviewRelease
Smartling: Applied SDK to com.smartling.demo.common.CommonActivity

> Task :app:transformClassesWithSmartlingForReviewRelease
Smartling: Applied SDK to com.smartling.demo.acmeapp.MainActivity


BUILD SUCCESSFUL in 17s
206 actionable tasks: 200 executed, 6 up-to-date

```

Assemble the App with the SDK disabled:

```sh
➜  AcmeApp git:(multimodules) ✗ ./gradlew clean assemble

> Configure project :app
NO MATCH FOUND

> Configure project :common
Smartling pre-check mode: disabled


BUILD SUCCESSFUL in 15s

```
