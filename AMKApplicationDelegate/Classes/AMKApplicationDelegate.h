//
//  AMKApplicationDelegate.h
//  AMKApplicationDelegate
//
//  Created by Meng,Xinxin on 2018/5/3.
//

#import <Foundation/Foundation.h>

/** 主ApplicationDelegate */
@protocol AMKMainApplicationDelegate @end


/** ApplicationDelegate 解耦 */
@interface AMKApplicationDelegate : NSObject <UIApplicationDelegate> {
    @protected NSArray<id<UIApplicationDelegate>> *_applicationDelegates;
}
@property(nonatomic, strong, readonly) NSArray<id<UIApplicationDelegate>> *applicationDelegates;
@property(nonatomic, strong, readonly) id<UIApplicationDelegate> mainApplicationDelegate;
@end
