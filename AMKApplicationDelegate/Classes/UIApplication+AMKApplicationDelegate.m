//
//  UIApplication+AMKApplicationDelegate.m
//  AMKApplicationDelegate
//
//  Created by Meng,Xinxin on 2018/5/3.
//

#import "UIApplication+AMKApplicationDelegate.h"
#import "AMKApplicationDelegate.h"
#import <objc/runtime.h>

@implementation UIApplication (AMKApplicationDelegate)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        void (^__method_swizzling)(SEL, SEL) = ^(SEL sel, SEL _sel) {
            Method  method = class_getInstanceMethod(self, sel);
            Method _method = class_getInstanceMethod(self, _sel);
            method_exchangeImplementations(method, _method);
        };
        __method_swizzling(@selector(delegate), @selector(AMKApplicationDelegate_delegate));
    });
}

- (id<UIApplicationDelegate>)AMKApplicationDelegate_delegate {
    id<UIApplicationDelegate> delegate = [self AMKApplicationDelegate_delegate];
    if ([delegate isKindOfClass:AMKApplicationDelegate.class]) {
        delegate = ((AMKApplicationDelegate *)delegate).mainApplicationDelegate;
    }
    return delegate;
}

@end
