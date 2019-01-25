//
//  AMKApplicationShortcutManager.m
//  AMKApplicationDelegate_Example
//
//  Created by 孟昕欣 on 2019/1/25.
//  Copyright © 2019年 mengxinxin. All rights reserved.
//

#import "AMKApplicationShortcutManager.h"

NSString * const AMKApplicationShortcutItemTitleUserInfoKey = @"title";
NSString * const AMKApplicationShortcutItemMessageUserInfoKey = @"message";

@implementation AMKApplicationShortcutManager

#pragma mark - Init Methods

- (void)dealloc {
    
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Properties

#pragma mark - Public Methods

#pragma mark - Private Methods

/** 快捷入口 */
- (void)setupShortcutItems {
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(shortcutItems)]) {
        NSMutableArray *shortcutItems = [NSMutableArray array];
        
        [shortcutItems addObject:({
            NSString *type = @"shortcutItem1";
            NSString *title = @"签到";
            NSString *subtitle = @"我是快捷操作描述";
            NSString *message = [NSString stringWithFormat:@"您点击了“%@”的快捷方式", title];
            
            NSMutableDictionary *userInfo = @{}.mutableCopy;
            userInfo[AMKApplicationShortcutItemTitleUserInfoKey] = title;
            userInfo[AMKApplicationShortcutItemMessageUserInfoKey] = message;
            
            UIApplicationShortcutItem *shortcutItem = [[UIApplicationShortcutItem alloc] initWithType:type localizedTitle:title localizedSubtitle:subtitle icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@""] userInfo:userInfo];
            shortcutItem;
        })];
        
        [shortcutItems addObject:({
            NSString *type = @"shortcutItem2";
            NSString *title = @"查找";
            NSString *subtitle = @"我是快捷操作描述";
            NSString *message = [NSString stringWithFormat:@"您点击了“%@”的快捷方式", title];
            
            NSMutableDictionary *userInfo = @{}.mutableCopy;
            userInfo[AMKApplicationShortcutItemTitleUserInfoKey] = title;
            userInfo[AMKApplicationShortcutItemMessageUserInfoKey] = message;
            
            UIApplicationShortcutItem *shortcutItem = [[UIApplicationShortcutItem alloc] initWithType:type localizedTitle:title localizedSubtitle:subtitle icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@""] userInfo:userInfo];
            shortcutItem;
        })];
        
        [UIApplication sharedApplication].shortcutItems = shortcutItems;
    }
}

#pragma mark - Notifications

#pragma mark - KVO

#pragma mark - Delegate

#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
    [self setupShortcutItems];
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    NSString *title = [shortcutItem.userInfo objectForKey:AMKApplicationShortcutItemTitleUserInfoKey];
    NSString *message = [shortcutItem.userInfo objectForKey:AMKApplicationShortcutItemMessageUserInfoKey];
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

#pragma mark - Override

#pragma mark - Helper Methods

@end
