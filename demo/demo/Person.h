//
//  Person.h
//  demo
//
//  Created by 张 玺 on 13-4-9.
//  Copyright (c) 2013年 张玺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Car, Person;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rowHeight;
@property (nonatomic, retain) NSNumber * realPerson;
@property (nonatomic, retain) NSSet *friends;
@property (nonatomic, retain) NSSet *ownCar;
@property (nonatomic, retain) Person *myfriends;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addFriendsObject:(Person *)value;
- (void)removeFriendsObject:(Person *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

- (void)addOwnCarObject:(Car *)value;
- (void)removeOwnCarObject:(Car *)value;
- (void)addOwnCar:(NSSet *)values;
- (void)removeOwnCar:(NSSet *)values;

@end
