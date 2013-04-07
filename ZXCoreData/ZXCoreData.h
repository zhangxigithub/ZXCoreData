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

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;
@end
