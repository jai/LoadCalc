//
//  AppDelegate.m
//
//  Copyright (c) 2015 Evgeny Aleksandrov. All rights reserved.

#import "AppDelegate.h"
#import <SimulatorStatusMagic/SDStatusBarManager.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSString *bundleShortVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *bundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSLog(@"Starting %@ v%@ (%@)", bundleId, bundleShortVersion, bundleVersion);
    
    [Fabric with:@[CrashlyticsKit]];
    
#ifdef SNAPSHOT
    [[SDStatusBarManager sharedInstance] enableOverrides];
#endif
    
    return YES;
}

@end
