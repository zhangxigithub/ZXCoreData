//
//  ZXCoreData.h
//  demo
//
//  Created by 张玺 on 13-4-6.
//  Copyright (c) 2013年 张玺. All rights reserved.
//


#define kZXCoreDataModalName      @"model"
#define kZXCoreDataModalExtension @"momd"
#define kZXCoreDataFileName       @"zxcoredata"
#define kZXCoreDataFileExtension  @"sqlite"


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ZXCoreData : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//临时上下文，用来生成临时对象，不会被写入磁盘
@property (nonatomic, strong, readonly) NSManagedObjectContext *tempContext;



-(void)performSafeBlock:(void(^)())block;
//生成对象，并存入库
-(id)objectForName:(NSString *)name;
//生成临时对象，
-(id)tempObjectForName:(NSString *)name;


- (NSArray *)executeFetchRequest:(NSFetchRequest *)request error:(NSError **)error; 


- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;
@end
