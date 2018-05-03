//
//  AMKAppDelegate.m
//  AMKApplicationDelegate
//
//  Created by mengxinxin on 05/03/2018.
//  Copyright (c) 2018 mengxinxin. All rights reserved.
//

#import "AMKAppDelegate.h"
#import "AMKViewController.h"
#import "AMKAppDelegate+LanuchAd.h"
#import "AMKAppDelegate+UserNotification.h"


@implementation AMKApplicationDelegate (Demo)

- (instancetype)init {
    if (self = [super init]) {
        self->_applicationDelegates = @[AMKAppDelegate.new, AMKLanuchAdAppDelegate.new, AMKUserNotificationAppDelegate.new];
    }
    return self;
}

@end



@implementation AMKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:AMKViewController.new];
    [self.window makeKeyAndVisible];
    NSLog(@"加载配置：主代理");
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end