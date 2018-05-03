//
//  AMKApplicationDelegate.m
//  AMKApplicationDelegate
//
//  Created by Meng,Xinxin on 2018/5/3.
//

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
#import "AMKApplicationDelegate.h"


@interface AMKApplicationDelegate () @end

@implementation AMKApplicationDelegate

#pragma mark - Properties

@synthesize applicationDelegates = _applicationDelegates;

- (UIWindow *)window {
    return self.mainApplicationDelegate.window;
}

#pragma mark - Public Methods

- (id<UIApplicationDelegate>)mainApplicationDelegate {
    static id<UIApplicationDelegate> mainApplicationDelegate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 查找主代理
        for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
            if ([applicationDelegate conformsToProtocol:@protocol(AMKMainApplicationDelegate)]) {
                // 断言
                NSAssert(mainApplicationDelegate==nil, @"`AMKMainApplicationDelegate` 协议的实现类有且仅有一个");
                
                // 赋值主代理
                mainApplicationDelegate = applicationDelegate;
            }
        }
        
        // 主代理有效性判断
        NSAssert(mainApplicationDelegate!=nil, @"`AMKMainApplicationDelegate` 协议的实现类有且仅有一个");
        
    });
    return mainApplicationDelegate;
}

#pragma mark - Life Circle

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate applicationDidFinishLaunching:application];
    }
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
    BOOL flag = YES;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        flag = flag && [applicationDelegate application:application willFinishLaunchingWithOptions:launchOptions];
    }
    return flag;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
    BOOL flag = YES;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        flag = flag && [applicationDelegate application:application didFinishLaunchingWithOptions:launchOptions];
    }
    return flag;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate applicationDidBecomeActive:application];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate applicationWillResignActive:application];
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL flag = NO;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        flag = flag || [applicationDelegate application:application handleOpenURL:url];
    }
    return flag;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    BOOL flag = NO;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        flag = flag || [applicationDelegate application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
    return flag;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    if (@available(iOS 9.0, *)) {
        BOOL flag = NO;
        for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
            if (![applicationDelegate respondsToSelector:_cmd]) continue;
            flag = flag || [applicationDelegate application:application openURL:url options:options];
        }
        return flag;
    } else {
        return NO;
    }
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate applicationDidReceiveMemoryWarning:application];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate applicationWillTerminate:application];
    }
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate applicationSignificantTimeChange:application];
    }
}

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application willChangeStatusBarOrientation:newStatusBarOrientation duration:duration];
    }
}

- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application didChangeStatusBarOrientation:oldStatusBarOrientation];
    }
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application willChangeStatusBarFrame:newStatusBarFrame];
    }
}

- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application didChangeStatusBarFrame:oldStatusBarFrame];
    }
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application didRegisterUserNotificationSettings:notificationSettings];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application didFailToRegisterForRemoteNotificationsWithError:error];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application didReceiveRemoteNotification:userInfo];
    }
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application didReceiveLocalNotification:notification];
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo withResponseInfo:responseInfo completionHandler:completionHandler];
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo completionHandler:completionHandler];
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application handleActionWithIdentifier:identifier forLocalNotification:notification withResponseInfo:responseInfo completionHandler:completionHandler];
    }
}

#ifdef AMKAPPLICATIONDELEGATE_BACKGROUNDMODE_REMOTENOTIFICATION

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
    }
}

#endif

#ifdef AMKAPPLICATIONDELEGATE_BACKGROUNDMODE_FETCH

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application performFetchWithCompletionHandler:completionHandler];
    }
}

#endif

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler {
    if (@available(iOS 9.0, *)) {
        for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
            if (![applicationDelegate respondsToSelector:_cmd]) continue;
            [applicationDelegate application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    } else {
        // Fallback on earlier versions
    }
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
    }
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(nullable NSDictionary *)userInfo reply:(void(^)(NSDictionary * __nullable replyInfo))reply {
    if (@available(iOS 8.2, *)) {
        for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
            if (![applicationDelegate respondsToSelector:_cmd]) continue;
            [applicationDelegate application:application handleWatchKitExtensionRequest:userInfo reply:reply];
        }
    } else {
        // Fallback on earlier versions
    }
}

- (void)applicationShouldRequestHealthAuthorization:(UIApplication *)application {
    if (@available(iOS 9.0, *)) {
        for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
            if (![applicationDelegate respondsToSelector:_cmd]) continue;
            [applicationDelegate applicationShouldRequestHealthAuthorization:application];
        }
    } else {
        // Fallback on earlier versions
    }
}

- (void)application:(UIApplication *)application handleIntent:(INIntent *)intent completionHandler:(void(^)(INIntentResponse *intentResponse))completionHandler {
    if (@available(iOS 11.0, *)) {
        for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
            if (![applicationDelegate respondsToSelector:_cmd]) continue;
            [applicationDelegate application:application handleIntent:intent completionHandler:completionHandler];
        }
    } else {
        // Fallback on earlier versions
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate applicationDidEnterBackground:application];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate applicationWillEnterForeground:application];
    }
}

- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate applicationProtectedDataWillBecomeUnavailable:application];
    }
}

- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate applicationProtectedDataDidBecomeAvailable:application];
    }
}


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    UIInterfaceOrientationMask orientations = 0;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        orientations = orientations | [applicationDelegate application:application supportedInterfaceOrientationsForWindow:window];
    }
    return orientations;
}

- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier {
    BOOL flag = NO;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        flag = flag || [applicationDelegate application:application shouldAllowExtensionPointIdentifier:extensionPointIdentifier];
    }
    return flag;
}

#pragma mark -- State Restoration protocol adopted by UIApplication delegate --

#ifdef AMKAPPLICATIONDELEGATE_STATERESTORATION_ENABLE

- (nullable UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
    UIViewController *viewController = nil;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        viewController = [applicationDelegate application:application viewControllerWithRestorationIdentifierPath:identifierComponents coder:coder]?:viewController;
    }
    return viewController;
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    BOOL flag = YES;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        flag = flag && [applicationDelegate application:application shouldSaveApplicationState:coder];
    }
    return flag;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    BOOL flag = YES;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        flag = flag && [applicationDelegate application:application shouldRestoreApplicationState:coder];
    }
    return flag;
}

- (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application willEncodeRestorableStateWithCoder:coder];
    }
}

- (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application didDecodeRestorableStateWithCoder:coder];
    }
}

#endif

#pragma mark -- User Activity Continuation protocol adopted by UIApplication delegate --

- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType {
    BOOL flag = NO;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        flag = flag || [applicationDelegate application:application willContinueUserActivityWithType:userActivityType];
    }
    return flag;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler {
    BOOL flag = NO;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        flag = flag || [applicationDelegate application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
    }
    return flag;
}

- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application didFailToContinueUserActivityWithType:userActivityType error:error];
    }
}

- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:_cmd]) continue;
        [applicationDelegate application:application didUpdateUserActivity:userActivity];
    }
}

#pragma mark -- CloudKit Sharing Invitation Handling --

- (void)application:(UIApplication *)application userDidAcceptCloudKitShareWithMetadata:(CKShareMetadata *)cloudKitShareMetadata {
    if (@available(iOS 10.0, *)) {
        for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
            if (![applicationDelegate respondsToSelector:_cmd]) continue;
            [applicationDelegate application:application userDidAcceptCloudKitShareWithMetadata:cloudKitShareMetadata];
        }
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark - Private Methods

@end

#pragma clang diagnostic pop
