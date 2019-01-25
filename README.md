# AppDelegate瘦身 之  AMKApplicationDelegate

[![Platform](https://img.shields.io/cocoapods/p/AMKApplicationDelegate.svg?style=flat)](http://cocoapods.org/pods/AMKApplicationDelegate)
[![Language](https://img.shields.io/badge/Language-%20Objective%20C%20-blue.svg)]()
[![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)
[![Version](https://img.shields.io/cocoapods/v/AMKApplicationDelegate.svg?style=flat)](http://cocoapods.org/pods/AMKApplicationDelegate)
[![License](https://img.shields.io/cocoapods/l/AMKApplicationDelegate.svg?style=flat)](http://cocoapods.org/pods/AMKApplicationDelegate)
[![Weibo](https://img.shields.io/badge/Sina微博-@Developer_Andy-orange.svg?style=flat)](http://weibo.com/u/5271489088)
[![GitHub stars](https://img.shields.io/github/stars/AndyM129/AMKApplicationDelegate.svg)](https://github.com/AndyM129/AMKApplicationDelegate/stargazers)
[![Download](https://img.shields.io/cocoapods/dt/AMKApplicationDelegate.svg)](https://github.com/AndyM129/AMKApplicationDelegate/archive/master.zip)


> 本文原文地址：[https://www.jianshu.com/p/666cbd2b7ec8](https://www.jianshu.com/p/666cbd2b7ec8)
> 代码地址：[https://github.com/AndyM129/AMKApplicationDelegate](https://github.com/AndyM129/AMKApplicationDelegate)



## 背景

在iOS项目的开发中，AppDelegate是一个耦合发生的重灾地，很多项目的开发时间一长，AppDelegate就不可避免地出现，代码臃肿，调用顺序混乱，逻辑复杂的问题。

因此，可通过 `AMKApplicationDelegate` 无侵入的实现AppDelegate瘦身。



## AppDelegate瘦身 之  AMKApplicationDelegate

**“AppDelegate瘦身”** 真的是一个老生常谈的话题了，之所以再次提起，是因为我在刷博客时，偶然间看到这样一段内容：

![图片](http://upload-images.jianshu.io/upload_images/294630-51e50c17923853ed?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

看完这段精辟的见解后，我真的是有一种 **久旱逢甘露** 的感觉啊，为什么自己就早没想到呢 —— 在参与开发的若干项目中，每一个项目的`AppDelegate`真可谓是 **没有最臃肿，只有更臃肿**，虽然通过 **分类** 做了些许优化，但效果都不是很理想：

- 后期维护时，一段代码写在哪里更合理，需要研发的个人素养去判断，一不留神，好不容易做的优化就又乱了
- 相同方法的实现在分类之间会互相覆盖，所以只能通过 **别名**（如加前缀）的方法实现，再统一调用，但最终会导致主类中引入大量的分类，和方法调用逻辑



## 思考

在理解了上图的思想后，我没有盲目的动手Coding，而是打开Github，键入[`AppDelegate`](https://github.com/search?utf8=%E2%9C%93&q=AppDelegate&type=)，搜一遍看看有什么现有的好的实现~~

其中，[《DelegateDietDemo - AppDelegate瘦身指南Demo》](https://github.com/zjh171/DelegateDietDemo) （另可见[原文](http://kyson.cn/index.php/archives/105/)）对目前常见的方案做了一个梳理，但我觉得都不足够好：


所以，我想了另外一种方案，更准确的说，是几种方案的结合：

1. 将之前的每一个**分类**都改为一个独立的**代理类**，以处理该模块中App在各生命周期的事项
2. 通过一个**管理类**来代替原有的`AppDelegate`，使得该**管理类**可以分发生命周期的各方法到对应**代理类**
3. 在若干**代理类**中标记一个**主代理**，做一些统筹，或`UIWindow`的实例化等操作
4. `main.m`文件中，改用**代理类**
```
int main(int argc, char * argv[]) {
@autoreleasepool {
// 之前的用法
// return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));

// 改用 管理类
return UIApplicationMain(argc, argv, nil, NSStringFromClass([AMKApplicationDelegate class]));
}
}
```

如下是新方案与目前现有开源的解决方案的优劣势对比：

![b3e88078de6729ac9e0a374bf0b450e68a5d998e.png](https://upload-images.jianshu.io/upload_images/294630-1c30edc6b9839145.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



## 核心代码

> 注：该项目在 Xcode Version 9.2 上开发，目标支持iOS8+，没有测试更早的iOS版本。



### AMKApplicationDelegate.h

```
//
//  AMKApplicationDelegate.h
//  AMKApplicationDelegate
//
//  Created by Meng,Xinxin on 2018/5/3.
//

#import <UIKit/UIKit.h>


/** ApplicationDelegate 解耦 */
@interface AMKApplicationDelegate : UIResponder <UIApplicationDelegate> {
@protected NSArray<id<UIApplicationDelegate>> *_applicationDelegates;
}
@property(nonatomic, strong, readonly, class) AMKApplicationDelegate *sharedInstance;
@property(nonatomic, strong, readonly) NSArray<id<UIApplicationDelegate>> *applicationDelegates;
@property(nonatomic, strong, readonly) UIResponder<UIApplicationDelegate> *mainApplicationDelegate;
@end


/** 主ApplicationDelegate */
@protocol AMKMainApplicationDelegate <UIApplicationDelegate> @end

```



### AMKApplicationDelegate.m

```
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

...

@implementation AMKApplicationDelegate (UIApplicationDelegate)

...

// 当应用程序启动完毕的时候就会调用(系统自动调用)
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
BOOL flag = YES;
for (id<UIApplicationDelegate> applicationDelegate in self.applicationDelegates) {
if (![applicationDelegate respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) continue;
flag = flag && [applicationDelegate application:application didFinishLaunchingWithOptions:launchOptions];
}
return flag;
}

...

@end

```



## 使用

### 1. 引入

`AMKApplicationDelegate` 可通过[CocoaPods](https://cocoapods.org)完成引入，仅需现在工程的`Podfile`文件中 添加如下代码

```ruby
pod 'AMKApplicationDelegate'
```

然后在终端在`Podfile`文件所在路径下执行 `pod install`命令即可完成源码下载与引入。

### 2. 接入

#### (1) 改写默认 AppDelegate

- 改写 `main.m` 文件

```objective-c
@import UIKit;
#import "AMKAppDelegate.h"

int main(int argc, char * argv[]) {
@autoreleasepool {
return UIApplicationMain(argc, argv, nil, NSStringFromClass(AMKApplicationDelegate.class));
}
}
```

#### (2) 注册 主AppDelegate

- 创建 `AMKApplicationDelegate` 的分类

```objective-c
// .h

#import <AMKApplicationDelegate/AMKApplicationDelegate.h>

@interface AMKApplicationDelegate (Demo) @end


// .m

#import "AMKApplicationDelegate+Demo.h"
#import "AMKAppDelegate.h"

@implementation AMKApplicationDelegate (Demo)

- (instancetype)init {
if (self = [super init]) {
NSMutableArray *applicationDelegates = [NSMutableArray array];
[applicationDelegates addObject:AMKAppDelegate.new];
self->_applicationDelegates = applicationDelegates;
}
return self;
}

@end
```

- 在 `AMKAppDelegate.h` 文件中实现 `AMKMainApplicationDelegate` 协议

```objective-c
#import "AMKApplicationDelegate.h"

@interface AMKAppDelegate : UIResponder <UIApplicationDelegate, AMKMainApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end
```

> 注：`AMKApplicationDelegate`本身没有去干预App生命周期方法中，各代理类的调用顺序，直接以初始化的顺序调用，使用者可以按需初始化~

### 3. 开发

如下是以 “添加 3D-Touch快捷方式” 为例，介绍如何横向扩展 AppDelegate。

#### (1) 创建管理类

- `AMKApplicationShortcutManager.h`

```objective-c
#import <Foundation/Foundation.h>

/// 快捷方式
@interface AMKApplicationShortcutManager : NSObject <UIApplicationDelegate>

@end
```

- `AMKApplicationShortcutManager.m`

```objective-c
#import "AMKApplicationShortcutManager.h"

NSString * const AMKApplicationShortcutItemTitleUserInfoKey = @"title";
NSString * const AMKApplicationShortcutItemMessageUserInfoKey = @"message";

@implementation AMKApplicationShortcutManager

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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
[self setupShortcutItems];
return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
NSString *title = [shortcutItem.userInfo objectForKey:AMKApplicationShortcutItemTitleUserInfoKey];
NSString *message = [shortcutItem.userInfo objectForKey:AMKApplicationShortcutItemMessageUserInfoKey];
[[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

@end

```

#### (2) 注册

- 在 `AMKApplicationDelegate+Demo.m` 分类文件中注册新创建的管理类

```objective-c
#import "AMKApplicationDelegate+Demo.h"
#import "AMKApplicationShortcutManager.h"

@implementation AMKApplicationDelegate (Demo)

- (instancetype)init {
if (self = [super init]) {
NSMutableArray *applicationDelegates = [NSMutableArray array];
[applicationDelegates addObject:AMKAppDelegate.new];
[applicationDelegates addObject:AMKApplicationShortcutManager.new]; // 注册 3D-Touch快捷方式
self->_applicationDelegates = applicationDelegates;
}
return self;
}

@end
```



### 执行结果

![demo.gif](https://upload-images.jianshu.io/upload_images/294630-3b5531a5137189d3.gif?imageMogr2/auto-orient/strip)

> 图片有点大，若加载失败 请前往如下地址查看：
> https://github.com/AndyM129/AMKApplicationDelegate/blob/master/demo.gif 



## 后话

本文原文地址：[https://www.jianshu.com/p/666cbd2b7ec8](https://www.jianshu.com/p/666cbd2b7ec8)
代码地址：[https://github.com/AndyM129/AMKApplicationDelegate](https://github.com/AndyM129/AMKApplicationDelegate)

如果你有好的 idea 或 疑问，请随时提 issue 或 request。

如果你在开发过程中遇到什么问题，或对iOS开发有着自己独到的见解，再或是你与我一样同为菜鸟，都可以关注或私信我的微博。

- 微信：Andy_129
- 微博：[@Developer_Andy](http://weibo.com/u/5271489088)
- 简书：[Andy__M](http://www.jianshu.com/users/28d89b68984b)

>“Stay hungry. Stay foolish.”

共勉~
