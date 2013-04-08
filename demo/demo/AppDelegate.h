//
//  AppDelegate.h
//  demo
//
//  Created by 张玺 on 13-4-6.
//  Copyright (c) 2013年 张玺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXCoreData.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    ZXCoreData *helper;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
