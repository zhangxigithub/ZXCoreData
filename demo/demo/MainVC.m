//
//  MainVC.m
//  demo
//
//  Created by 张 玺 on 13-4-9.
//  Copyright (c) 2013年 张玺. All rights reserved.
//

#import "MainVC.h"
#import "ZXCoreData.h"

@implementation MainVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)load:(id)sender {
    
    ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)clean:(id)sender {
    ZXCoreData *helper = [ZXCoreData sharedZXCoreData];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    NSArray *array = [helper.managedObjectContext executeFetchRequest:request
                                                                error:nil];
    for(NSManagedObject *object in array)
        [helper.managedObjectContext deleteObject:object];
}
@end
