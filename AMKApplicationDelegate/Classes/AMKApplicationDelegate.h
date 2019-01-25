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

