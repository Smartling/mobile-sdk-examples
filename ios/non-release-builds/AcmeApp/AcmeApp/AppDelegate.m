//
//  AppDelegate.m
//  AcmeApp
//
//  Created by Scott Rossillo on 8/21/18.
//  Copyright © 2018 Smartling, Inc. All rights reserved.
//

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
