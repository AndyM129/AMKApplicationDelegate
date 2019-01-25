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

#pragma mark -- Properties --

@synthesize applicationDelegates = _applicationDelegates;

- (UIWindow *)window {
    return self.mainApplicationDelegate.window;
}

#pragma mark -- Public Methods --

+ (AMKApplicationDelegate *)sharedInstance {
    static AMKApplicationDelegate *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (UIResponder<UIApplicationDelegate> *)mainApplicationDelegate {
    static UIResponder<UIApplicationDelegate> *mainApplicationDelegate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 查找主代理
        for (UIResponder<UIApplicationDelegate> *applicationDelegate in self.applicationDelegates) {
            if ([applicationDelegate conformsToProtocol:@protocol(AMKMainApplicationDelegate)] && [applicationDelegate isKindOfClass:UIResponder.class]) {
                // 断言
                NSAssert(mainApplicationDelegate==nil, @"`AMKMainApplicationDelegate` 协议的实现类有且仅有一个");
                
                // 赋值主代理
                mainApplicationDelegate = applicationDelegate;
            }
        }
        
        // 主代理有效性判断
        NSAssert(mainApplicationDelegate!=nil, @"`AMKMainApplicationDelegate` 协议的实现类有且仅有一个, 且为`UIResponder`子类");
        
    });
    return mainApplicationDelegate;
}

@end

#pragma mark -

@implementation AMKApplicationDelegate (NSObject)

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.mainApplicationDelegate;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    // 查找是否有代理类实现该方法
    __block id<UIApplicationDelegate> applicationDelegateThatRespondsToSelector = nil;
    [self.applicationDelegates enumerateObjectsUsingBlock:^(id<UIApplicationDelegate>  _Nonnull applicationDelegate, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([applicationDelegate respondsToSelector:aSelector]) {
            applicationDelegateThatRespondsToSelector = applicationDelegate;
            *stop = YES;
        }
    }];
    
    // 若有代理类实现该方法时返回YES, 否则返回super的结果
    return applicationDelegateThatRespondsToSelector ? YES : [super respondsToSelector:aSelector];
}

@end

#pragma mark -

@implementation AMKApplicationDelegate (UIResponder)

#pragma mark -- Touches Event adopted by UIResponder --

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    for (UIResponder *applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate isKindOfClass:UIResponder.class]) continue;
        if (![applicationDelegate respondsToSelector:@selector(touchesBegan:withEvent:)]) continue;
        [applicationDelegate touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    for (UIResponder *applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate isKindOfClass:UIResponder.class]) continue;
        if (![applicationDelegate respondsToSelector:@selector(touchesMoved:withEvent:)]) continue;
        [applicationDelegate touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    for (UIResponder *applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate isKindOfClass:UIResponder.class]) continue;
        if (![applicationDelegate respondsToSelector:@selector(touchesEnded:withEvent:)]) continue;
        [applicationDelegate touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    for (UIResponder *applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate isKindOfClass:UIResponder.class]) continue;
        if (![applicationDelegate respondsToSelector:@selector(touchesCancelled:withEvent:)]) continue;
        [applicationDelegate touchesCancelled:touches withEvent:event];
    }
}

- (void)touchesEstimatedPropertiesUpdated:(NSSet<UITouch *> *)touches {
    for (UIResponder *applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate isKindOfClass:UIResponder.class]) continue;
        if (![applicationDelegate respondsToSelector:@selector(touchesEstimatedPropertiesUpdated:)]) continue;
        [applicationDelegate touchesEstimatedPropertiesUpdated:touches];
    }
}

#pragma mark -- Presses Event adopted by UIResponder --

- (void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event {
    for (UIResponder *applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate isKindOfClass:UIResponder.class]) continue;
        if (![applicationDelegate respondsToSelector:@selector(pressesBegan:withEvent:)]) continue;
        [applicationDelegate pressesBegan:presses withEvent:event];
    }
}

- (void)pressesChanged:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event {
    for (UIResponder *applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate isKindOfClass:UIResponder.class]) continue;
        if (![applicationDelegate respondsToSelector:@selector(pressesChanged:withEvent:)]) continue;
        [applicationDelegate pressesChanged:presses withEvent:event];
    }
}

- (void)pressesEnded:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event {
    for (UIResponder *applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate isKindOfClass:UIResponder.class]) continue;
        if (![applicationDelegate respondsToSelector:@selector(pressesEnded:withEvent:)]) continue;
        [applicationDelegate pressesEnded:presses withEvent:event];
    }
}

- (void)pressesCancelled:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event {
    for (UIResponder *applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate isKindOfClass:UIResponder.class]) continue;
        if (![applicationDelegate respondsToSelector:@selector(pressesCancelled:withEvent:)]) continue;
        [applicationDelegate pressesCancelled:presses withEvent:event];
    }
}

#pragma mark -- Motion Event adopted by UIResponder --

- (void)motionBegan:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event {
    for (UIResponder *applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate isKindOfClass:UIResponder.class]) continue;
        if (![applicationDelegate respondsToSelector:@selector(motionBegan:withEvent:)]) continue;
        [applicationDelegate motionBegan:motion withEvent:event];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event {
    for (UIResponder *applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate isKindOfClass:UIResponder.class]) continue;
        if (![applicationDelegate respondsToSelector:@selector(motionEnded:withEvent:)]) continue;
        [applicationDelegate motionEnded:motion withEvent:event];
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event {
    for (UIResponder *applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate isKindOfClass:UIResponder.class]) continue;
        if (![applicationDelegate respondsToSelector:@selector(motionCancelled:withEvent:)]) continue;
        [applicationDelegate motionCancelled:motion withEvent:event];
    }
}

#pragma mark -- Remote Control Event adopted by UIResponder --

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    for (UIResponder *applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate isKindOfClass:UIResponder.class]) continue;
        if (![applicationDelegate respondsToSelector:@selector(remoteControlReceivedWithEvent:)]) continue;
        [applicationDelegate remoteControlReceivedWithEvent:event];
    }
}

@end

#pragma mark -

@implementation AMKApplicationDelegate (UIApplicationDelegate)

#pragma mark -- Application State protocol adopted by UIApplication delegate --

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
    BOOL flag = YES;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:willFinishLaunchingWithOptions:)]) continue;
        flag = flag && [applicationDelegate application:application willFinishLaunchingWithOptions:launchOptions];
    }
    return flag;
}

// 当应用程序启动完毕的时候就会调用(系统自动调用)
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
    BOOL flag = YES;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) continue;
        flag = flag && [applicationDelegate application:application didFinishLaunchingWithOptions:launchOptions];
    }
    return flag;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(applicationDidFinishLaunching:)]) continue;
        [applicationDelegate applicationDidFinishLaunching:application];
    }
}

// 应用程序即将进入前台的时候调用
- (void)applicationWillEnterForeground:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(applicationWillEnterForeground:)]) continue;
        [applicationDelegate applicationWillEnterForeground:application];
    }
}

// 重新获取焦点(能够和用户交互)
- (void)applicationDidBecomeActive:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(applicationDidBecomeActive:)]) continue;
        [applicationDelegate applicationDidBecomeActive:application];
    }
}

// 即将失去活动状态的时候调用(失去焦点, 不可交互)
- (void)applicationWillResignActive:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(applicationWillResignActive:)]) continue;
        [applicationDelegate applicationWillResignActive:application];
    }
}

// 应用程序进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(applicationDidEnterBackground:)]) continue;
        [applicationDelegate applicationDidEnterBackground:application];
    }
}

// 应用程序接收到内存警告的时候就会调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(applicationDidReceiveMemoryWarning:)]) continue;
        [applicationDelegate applicationDidReceiveMemoryWarning:application];
    }
}

// 应用程序即将被销毁的时候会调用该方法
- (void)applicationWillTerminate:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(applicationWillTerminate:)]) continue;
        [applicationDelegate applicationWillTerminate:application];
    }
}

//#pragma mark -- Application Default Orientation protocol adopted by UIApplication delegate --
//
// 与info.plist中设置的屏幕方向参数，当使用了该方法的时候info.plist中的方向即无效（无该方法的时候，即用plist中的设置）
//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
//    UIInterfaceOrientationMask orientations = 0;
//    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
//        if (![applicationDelegate respondsToSelector:@selector(supportedInterfaceOrientationsForWindow:)]) continue;
//        orientations = orientations | [applicationDelegate application:application supportedInterfaceOrientationsForWindow:window];
//    }
//    return orientations;
//}

#pragma mark -- Application Background Fetch protocol adopted by UIApplication delegate --

#ifdef AMKAPPLICATIONDELEGATE_BACKGROUNDMODE_FETCH

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:performFetchWithCompletionHandler:)]) continue;
        [applicationDelegate application:application performFetchWithCompletionHandler:completionHandler];
    }
}

#endif

#pragma mark -- Application Remote Notifications protocol adopted by UIApplication delegate --

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]) continue;
        [applicationDelegate application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)]) continue;
        [applicationDelegate application:application didFailToRegisterForRemoteNotificationsWithError:error];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:didReceiveRemoteNotification:)]) continue;
        [applicationDelegate application:application didReceiveRemoteNotification:userInfo];
    }
}

#ifdef AMKAPPLICATIONDELEGATE_BACKGROUNDMODE_REMOTENOTIFICATION

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)]) continue;
        [applicationDelegate application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
    }
}

#endif

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:didRegisterUserNotificationSettings:)]) continue;
        [applicationDelegate application:application didRegisterUserNotificationSettings:notificationSettings];
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:handleActionWithIdentifier:forRemoteNotification:completionHandler:)]) continue;
        [applicationDelegate application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo completionHandler:completionHandler];
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:handleActionWithIdentifier:forRemoteNotification:withResponseInfo:completionHandler:)]) continue;
        [applicationDelegate application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo withResponseInfo:responseInfo completionHandler:completionHandler];
    }
}

#pragma mark -- Application Local Notifications protocol adopted by UIApplication delegate --

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:didReceiveLocalNotification:)]) continue;
        [applicationDelegate application:application didReceiveLocalNotification:notification];
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:handleActionWithIdentifier:forLocalNotification:completionHandler:)]) continue;
        [applicationDelegate application:application handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:handleActionWithIdentifier:forLocalNotification:withResponseInfo:completionHandler:)]) continue;
        [applicationDelegate application:application handleActionWithIdentifier:identifier forLocalNotification:notification withResponseInfo:responseInfo completionHandler:completionHandler];
    }
}

#pragma mark -- State Restoration protocol adopted by UIApplication delegate --

#ifdef AMKAPPLICATIONDELEGATE_STATERESTORATION_ENABLE

- (nullable UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
    UIViewController *viewController = nil;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:viewControllerWithRestorationIdentifierPath:coder:)]) continue;
        viewController = [applicationDelegate application:application viewControllerWithRestorationIdentifierPath:identifierComponents coder:coder]?:viewController;
    }
    return viewController;
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    BOOL flag = YES;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:shouldSaveApplicationState:)]) continue;
        flag = flag && [applicationDelegate application:application shouldSaveApplicationState:coder];
    }
    return flag;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    BOOL flag = YES;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:shouldRestoreApplicationState:)]) continue;
        flag = flag && [applicationDelegate application:application shouldRestoreApplicationState:coder];
    }
    return flag;
}

- (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:willEncodeRestorableStateWithCoder:)]) continue;
        [applicationDelegate application:application willEncodeRestorableStateWithCoder:coder];
    }
}

- (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:didDecodeRestorableStateWithCoder:)]) continue;
        [applicationDelegate application:application didDecodeRestorableStateWithCoder:coder];
    }
}

#endif

#pragma mark -- Application URL Resource Opening protocol adopted by UIApplication delegate --

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL flag = NO;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:handleOpenURL:)]) continue;
        flag = [applicationDelegate application:application handleOpenURL:url] || flag;
    }
    return flag;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    BOOL flag = NO;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:openURL:sourceApplication:annotation:)]) continue;
        flag = [applicationDelegate application:application openURL:url sourceApplication:sourceApplication annotation:annotation] || flag;
    }
    return flag;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    if (@available(iOS 9.0, *)) {
        BOOL flag = NO;
        for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
            if (![applicationDelegate respondsToSelector:@selector(application:openURL:options:)]) continue;
            flag = [applicationDelegate application:application openURL:url options:options] || flag;
        }
        return flag;
    } else {
        return NO;
    }
}

#pragma mark -- Application Shortcut Item protocol adopted by UIApplication delegate --

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler {
    if (@available(iOS 9.0, *)) {
        for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
            if (![applicationDelegate respondsToSelector:@selector(application:performActionForShortcutItem:completionHandler:)]) continue;
            [applicationDelegate application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark -- Application Health protocol adopted by UIApplication delegate --

- (void)applicationShouldRequestHealthAuthorization:(UIApplication *)application {
    if (@available(iOS 9.0, *)) {
        for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
            if (![applicationDelegate respondsToSelector:@selector(applicationShouldRequestHealthAuthorization:)]) continue;
            [applicationDelegate applicationShouldRequestHealthAuthorization:application];
        }
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark -- Application Protected Data protocol adopted by UIApplication delegate --

- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(applicationProtectedDataWillBecomeUnavailable:)]) continue;
        [applicationDelegate applicationProtectedDataWillBecomeUnavailable:application];
    }
}

- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(applicationProtectedDataDidBecomeAvailable:)]) continue;
        [applicationDelegate applicationProtectedDataDidBecomeAvailable:application];
    }
}

#pragma mark -- Application Watch Interaction protocol adopted by UIApplication delegate --

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(nullable NSDictionary *)userInfo reply:(void(^)(NSDictionary * __nullable replyInfo))reply {
    if (@available(iOS 8.2, *)) {
        for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
            if (![applicationDelegate respondsToSelector:@selector(application:handleWatchKitExtensionRequest:reply:)]) continue;
            [applicationDelegate application:application handleWatchKitExtensionRequest:userInfo reply:reply];
        }
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark -- Application Extension protocol adopted by UIApplication delegate --

- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier {
    BOOL flag = [extensionPointIdentifier isEqualToString:@"com.apple.keyboard-service"] ? YES : NO;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:shouldAllowExtensionPointIdentifier:)]) continue;
        flag = [applicationDelegate application:application shouldAllowExtensionPointIdentifier:extensionPointIdentifier] || flag;
    }
    return flag;
}

#pragma mark -- Application User Activity Continuation protocol adopted by UIApplication delegate --

- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType {
    BOOL flag = NO;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:willContinueUserActivityWithType:)]) continue;
        flag = [applicationDelegate application:application willContinueUserActivityWithType:userActivityType] || flag;
    }
    return flag;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler {
    BOOL flag = NO;
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:continueUserActivity:restorationHandler:)]) continue;
        flag = [applicationDelegate application:application continueUserActivity:userActivity restorationHandler:restorationHandler] || flag;
    }
    return flag;
}

- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:didFailToContinueUserActivityWithType:error:)]) continue;
        [applicationDelegate application:application didFailToContinueUserActivityWithType:userActivityType error:error];
    }
}

- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:didUpdateUserActivity:)]) continue;
        [applicationDelegate application:application didUpdateUserActivity:userActivity];
    }
}

#pragma mark -- URL Session protocol adopted by UIApplication delegate --

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:handleEventsForBackgroundURLSession:completionHandler:)]) continue;
        [applicationDelegate application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
    }
}

#pragma mark -- Application Status Bar protocol adopted by UIApplication delegate --

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:willChangeStatusBarOrientation:duration:)]) continue;
        [applicationDelegate application:application willChangeStatusBarOrientation:newStatusBarOrientation duration:duration];
    }
}

- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:didChangeStatusBarOrientation:)]) continue;
        [applicationDelegate application:application didChangeStatusBarOrientation:oldStatusBarOrientation];
    }
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:willChangeStatusBarFrame:)]) continue;
        [applicationDelegate application:application willChangeStatusBarFrame:newStatusBarFrame];
    }
}

- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(application:didChangeStatusBarFrame:)]) continue;
        [applicationDelegate application:application didChangeStatusBarFrame:oldStatusBarFrame];
    }
}

#pragma mark -- Application Significant Time Change protocol adopted by UIApplication delegate --

- (void)applicationSignificantTimeChange:(UIApplication *)application {
    for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
        if (![applicationDelegate respondsToSelector:@selector(applicationSignificantTimeChange:)]) continue;
        [applicationDelegate applicationSignificantTimeChange:application];
    }
}

#pragma mark -- SiriKit Intent protocol adopted by UIApplication delegate --

- (void)application:(UIApplication *)application handleIntent:(INIntent *)intent completionHandler:(void(^)(INIntentResponse *intentResponse))completionHandler {
    if (@available(iOS 11.0, *)) {
        for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
            if (![applicationDelegate respondsToSelector:@selector(application:handleIntent:completionHandler:)]) continue;
            [applicationDelegate application:application handleIntent:intent completionHandler:completionHandler];
        }
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark -- CloudKit Sharing Invitation Handling --

- (void)application:(UIApplication *)application userDidAcceptCloudKitShareWithMetadata:(CKShareMetadata *)cloudKitShareMetadata {
    if (@available(iOS 10.0, *)) {
        for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
            if (![applicationDelegate respondsToSelector:@selector(application:userDidAcceptCloudKitShareWithMetadata:)]) continue;
            [applicationDelegate application:application userDidAcceptCloudKitShareWithMetadata:cloudKitShareMetadata];
        }
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark - Private Methods

@end

#pragma clang diagnostic pop
