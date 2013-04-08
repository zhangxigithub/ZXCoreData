//
//  Person.m
//  core
//
//  Created by 张玺 on 13-4-6.
//  Copyright (c) 2013年 张玺. All rights reserved.
//

#import "Person.h"
#import "Car.h"


@implementation Person

@dynamic name;
@dynamic age;
@dynamic ownCar;


-(void)config:(NSDictionary *)data
{
    self.name = data[@"name"];
}

@end
