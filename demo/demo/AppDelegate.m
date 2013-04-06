//
//  AppDelegate.m
//  demo
//
//  Created by 张玺 on 13-4-6.
//  Copyright (c) 2013年 张玺. All rights reserved.
//

#import "AppDelegate.h"
#import "Person.h"
#import "Car.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[UIViewController alloc] init];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    
    //----------------------
    helper = [[ZXCoreData alloc] init];
    
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                                   inManagedObjectContext:helper.managedObjectContext];
    
    
    person.name = @"zx";
    person.age  = @24;
    
    
    for(int i =0 ;i<10;i++)
    {
        Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                                       inManagedObjectContext:helper.managedObjectContext];
        
        
        person.name = @"zx";
        person.age  = [NSNumber numberWithInt:i];
    }
    [helper saveContext];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Person"];

    [fetchRequest setFetchOffset:9];
    [fetchRequest setFetchLimit:6];
    
    
    NSArray *fetchedObjects = [helper.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    for (NSManagedObject *info in fetchedObjects) {
        NSLog(@"%@",info);
    }
    
    //----------------------
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [helper saveContext];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [helper saveContext];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    [helper saveContext];
}

@end
