//
//  AppDelegate.m
//  demo
//
//  Created by 张玺 on 13-4-6.
//  Copyright (c) 2013年 张玺. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Person.h"
#import "Car.h"
#import "AFNetworking.h"
#import "ZXMacro.h"
@implementation AppDelegate


static int i = 0;
-(void)next
{
    NSLog(@"%d",i);
//    [self performSelectorInBackground:@selector(backThread) withObject:nil];
//    [self performSelectorInBackground:@selector(backThread) withObject:nil];
//    [self performSelectorInBackground:@selector(backThread) withObject:nil];
//    [self performSelectorInBackground:@selector(backThread) withObject:nil];
//    [self performSelectorInBackground:@selector(backThread) withObject:nil];
//    [self performSelectorInBackground:@selector(backThread) withObject:nil];
//    [self performSelectorInBackground:@selector(backThread) withObject:nil];
    //[self performSelectorInBackground:@selector(backThread) withObject:nil];
    
    
    [self backThread];
}

-(void)backThread
{
    
    //if([NSThread isMainThread])
    {
        MAIN(^{
        
        

        for(int i=0;i<200;i++)
        {
            Person *person = [helper objectForName:@"Person"];
            person.name = @"张玺";
            person.age  = @10;
        }
        /*
            for(int i=0;i<999;i++)
            {
                NSManagedObjectContext *moc = [[NSManagedObjectContext alloc]
                                               initWithConcurrencyType:NSPrivateQueueConcurrencyType];
                moc.parentContext = helper.managedObjectContext;
                [moc performBlockAndWait:^{
                    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                                                   inManagedObjectContext:moc];
                    person.name = @"张玺";
                    person.age  = @10;

                }];

            }
        
        */
            NSLog(@"finish");
            
            
        
        });
    }
    


    /*
    @synchronized(self)
    {
        for(int i =0;i<50;i++)
        {
            Person *person = [helper objectForName:@"Person"];
            person.name = @"张玺";
            person.age  = @10;
        }
        NSLog(@"finish:%d",i++);

    };
    
    */
    /*
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc]
                                   initWithConcurrencyType:NSPrivateQueueConcurrencyType];

    moc.parentContext = helper.managedObjectContext;
    
    [moc performBlock:^{
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
        
       
            
            NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:nil];
            NSLog(@"%@",fetchedObjects);


    }];

       */ 

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    helper = [ZXCoreData sharedZXCoreData];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[ViewController alloc] init];
    
//    [self.viewController.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(next)]];
    
    self.viewController.view.backgroundColor = [UIColor grayColor];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    


    
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
