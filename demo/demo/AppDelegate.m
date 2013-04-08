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
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[ViewController alloc] init];
    
    [self.viewController.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(next)]];
    
    self.viewController.view.backgroundColor = [UIColor grayColor];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    

    
    
    
    
    NSDate *date1 = [NSDate date];
    

    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    NSArray *array = [helper executeFetchRequest:request error:nil];
    NSLog(@"count:%d",array.count);
    
    
    NSDate *date2 = [NSDate date];
    NSLog(@"%f",[date2 timeIntervalSinceDate:date1]);
    
    //[self performSelectorInBackground:@selector(backThread) withObject:nil];
    //----------------------
    helper = [[ZXCoreData alloc] init];
    
//    NSDate *date1 = [NSDate date];
//    for(int i =0;i<20;i++)
//    {
//        Person *person = [helper objectForName:@"Person"];
//        
//        person.name = @"张玺";
//        person.age  = [NSNumber numberWithInt:i];
//    }
//    NSDate *date2 = [NSDate date];
//    NSLog(@"%f",[date2 timeIntervalSinceDate:date1]);

    

    NSLog(@"start");
    //[self performSelectorInBackground:@selector(load) withObject:nil];
    //[self AFLoad];
    NSLog(@"end");
    
    
    
    //----------------------
    return YES;
}

-(void)AFLoad
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://zxapi.sinaapp.com/coredata.php"]];
    AFJSONRequestOperation *op;
    op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                             
} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
    BACK(^{
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [moc setParentContext:helper.managedObjectContext];
    
    [moc performBlockAndWait:^{

        NSDate *date1 = [NSDate date];
        for(int i =0;i<8000;i++)
        {
            Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                                           inManagedObjectContext:moc];
            
            person.name = @"张玺";
            person.age  = [NSNumber numberWithInt:i];
        }
        NSDate *date2 = [NSDate date];
        NSLog(@"%f",[date2 timeIntervalSinceDate:date1]);
        
        
        
    }];
        MAIN(^{
        
            NSLog(@"main");
        });
    
    });
  //if ([NSThread isMainThread]) ALERT(@"ad main");
                                                             
                                                             
}];
    [op start];
    
//    NSData *data = [NSURLConnection sendSynchronousRequest:request
//                                             returningResponse:nil
//                                                         error:nil];
//        [NSThread sleepForTimeInterval:2];
//        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        
//        
//        NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
//        [moc setParentContext:helper.managedObjectContext];
//        
//        [moc performBlockAndWait:^{
//            if([NSThread isMainThread]) ALERT(@"error");
//            NSDate *date1 = [NSDate date];
//            for(int i =0;i<8000;i++)
//            {
//                Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
//                                                               inManagedObjectContext:moc];
//                
//                person.name = @"张玺";
//                person.age  = [NSNumber numberWithInt:i];
//            }
//            NSDate *date2 = [NSDate date];
//            NSLog(@"%f",[date2 timeIntervalSinceDate:date1]);
//            
//            
//            NSLog(@"%@",dataString);
//            
//        }];
//
//        NSLog(@"------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
    

}
-(void)load
{
    BACK(^{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://zxapi.sinaapp.com/coredata.php"]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
    [NSThread sleepForTimeInterval:2];
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
        NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [moc setParentContext:helper.managedObjectContext];
        
        [moc performBlockAndWait:^{
            if([NSThread isMainThread]) ALERT(@"error");
            NSDate *date1 = [NSDate date];
            for(int i =0;i<8000;i++)
            {
                Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                                               inManagedObjectContext:moc];
                
                person.name = @"张玺";
                person.age  = [NSNumber numberWithInt:i];
            }
            NSDate *date2 = [NSDate date];
            NSLog(@"%f",[date2 timeIntervalSinceDate:date1]);
            
            
            NSLog(@"%@",dataString);
            
        }];
        
        NSLog(@"------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
        
        
        

        });

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
