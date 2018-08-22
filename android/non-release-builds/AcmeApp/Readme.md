# Smartling SDK Non-Release Only

This application uses the Smarting SDK for In-App Review and/or Context Capture.
The developer does not want to ship the Smartling SDK with release builds.

To accomplish this, we configure the Gradle build to only link the Smartling SDK in
certain build flavors. To do this we:

1. Enable Flavors in the Android config
2. Add the Smartling SDK as a Flavor Dependency 
3. Configure the Smartling SDK

## Enable Flavors in the Android Config

Android supports multiple build flavors. This can be used to ship differnt falvors of
your application (e.g. paid vs free, internal vs external, etc). We'll define a flavor
called "review" and another called "full" (this name does not matter). Android requires
that each flavor have a dimension, this is an arbitrary string. Here we've used "type."

```
android {
    compileSdkVersion 25
    defaultConfig { ... }
    buildTypes { ... }
    flavorDimensions "type"
    productFlavors {
        full {
            dimension "type"
        }
        review {
            dimension "type"
            applicationIdSuffix ".review"
        }
    }
}
```
## Add the Smartling SDK as a Flavor Dependency 

Since we don't want to ship the Smartling SDK as part of our final project,
we'll add it as a flavor specific dependency. 

Gradle 4.x and later:

   reviewImplementation "com.smartling.android:review:2.6.1"

Gradle 3.x or earlier:

    reviewCompile "com.smartling.android:review:2.6.1"

## Configure the Smartling SDK

We set the SDK to disabled by default and only enable it on the variant
flavor that we want to enable it for. Note the build variant name is the
flavor + Debug or Release.

```
smartling {
    projectId = "deaf9496f"
    mode = "disabled"
    logLevel = "verbose"
    buildVariants {
        reviewDebug {
            mode = "in-app-review"
        }
        reviewRelease {
            mode = "in-app-review"
        }
    }
}
```

## Running the Demo

You can clone this repository and run the AcmeApp. In Android Studio, set the build variant to
`reviewDebug` and run the application. The Smartling In-App Review feature will be available.

Change the build variant to `fullDebug` and clean the build. Run the application again, note that
the conditionals we used still allow the App to compile without the Smartling SDK being linked.
In this configuration, the Smartling SDK is not present in the built application.

This can also be confirmed by running a build on the command line.

Assemble the App with SDK enabled:

```
➜  AcmeApp git:(master) ✗ ./gradlew --info :app:clean :app:assembleReviewDebug |grep Smartling        
Smartling: building for variant reviewDebug
Smartling: SDK enabled for variant reviewDebug
Smartling: Config for reviewDebug: SmartlingConfig{name='reviewDebug', logLevel='verbose', mode='in-app-review', otaServing=null, auth=null}
Smartling: Add process manifest action to review-debug
Smartling: Config for reviewRelease: SmartlingConfig{name='reviewRelease', logLevel='verbose', mode='in-app-review', otaServing=null, auth=null}
Smartling: Add process manifest action to review-release
Smartling: Config for fullDebug: SmartlingConfig{name='fullDebug', logLevel='verbose', mode='disabled', otaServing=null, auth=null}
Smartling: Config for fullRelease: SmartlingConfig{name='fullRelease', logLevel='verbose', mode='disabled', otaServing=null, auth=null}
Smartling: Enabled? true
Smartling: Instrumenting activity classes
Smartling: Applied SDK to com.smartling.demo.acmeapp.MainActivity
:app:transformClassesWithSmartlingForReviewDebug (Thread[Task worker for ':' Thread 6,5,main]) completed. Took 0.337 secs.
```

Assemble the App with the SDK disabled:

```
➜  AcmeApp git:(master) ✗ ./gradlew --info :app:clean :app:assembleFullDebug |grep Smartling
Smartling: building for variant fullDebug
Smartling: Enabled? false
:app:transformClassesWithSmartlingForFullDebug (Thread[Task worker for ':',5,main]) completed. Took 0.016 secs.
```

