//
//  ColoredNavigationController.m
//
//  Copyright (c) 2015 Evgeny Aleksandrov. All rights reserved.

#import "ColoredNavigationController.h"
#import <ChameleonFramework/Chameleon.h>

@implementation ColoredNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [ChameleonStatusBar statusBarStyleForColor:self.navigationBar.barTintColor];
}

@end
