//
//  ViewController.h
//  demo
//
//  Created by 张玺 on 13-4-8.
//  Copyright (c) 2013年 张玺. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXCoreData;
@interface ViewController : UITableViewController
{
    ZXCoreData *helper;
}
@property(atomic,strong) NSMutableArray *localData;
@end
