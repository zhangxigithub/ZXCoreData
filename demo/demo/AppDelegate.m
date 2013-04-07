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
    self.viewController.view.backgroundColor = [UIColor grayColor];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    
    //----------------------
    helper = [[ZXCoreData alloc] init];
    
    for(int i =0;i<50;i++)
    {
        Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                                       inManagedObjectContext:helper.managedObjectContext];
        
        
        person.name = @"张玺";
        person.age  = [NSNumber numberWithInt:i];
    }
    
    [helper saveContext];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"age BETWEEN {10,15}"]];
    
    NSArray *fetchedObjects = [helper.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    
    for (Person *person in fetchedObjects) {

        NSLog(@"%@:%@",person.name,person.age);
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
