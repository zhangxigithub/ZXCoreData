//
//  Car.h
//  core
//
//  Created by 张玺 on 13-4-6.
//  Copyright (c) 2013年 张玺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Car : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Person *owner;

@end
