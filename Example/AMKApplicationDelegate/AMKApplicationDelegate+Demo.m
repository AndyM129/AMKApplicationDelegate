//
//  AMKApplicationDelegate+Demo.m
//  AMKApplicationDelegate_Example
//
//  Created by 孟昕欣 on 2019/1/25.
//  Copyright © 2019年 mengxinxin. All rights reserved.
//

#import "AMKApplicationDelegate+Demo.h"
#import "AMKAppDelegate+LanuchAd.h"
#import "AMKAppDelegate+UserNotification.h"
#import "AMKApplicationShortcutManager.h"

@implementation AMKApplicationDelegate (Demo)

- (instancetype)init {
    if (self = [super init]) {
        NSMutableArray *applicationDelegates = [NSMutableArray array];
        [applicationDelegates addObject:AMKAppDelegate.new];
        [applicationDelegates addObject:AMKLanuchAdAppDelegate.new];
        [applicationDelegates addObject:AMKUserNotificationAppDelegate.new];
        [applicationDelegates addObject:AMKApplicationShortcutManager.new];
        self->_applicationDelegates = applicationDelegates;
    }
    return self;
}

@end
