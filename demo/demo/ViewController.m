//
//  ViewController.m
//  demo
//
//  Created by 张玺 on 13-4-8.
//  Copyright (c) 2013年 张玺. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "ZXCoreData.h"
#import "Person.h"
#import "ZXMacro.h"

@implementation ViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

-(void)AFLoad
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://zxapi.sinaapp.com/coredata.php"]];
    AFJSONRequestOperation *op;
    op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                             
                                                         } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                             NSLog(@"geeeeeeeeeet");
                                                             
     BACK(^{
         
         NSManagedObjectContext *moc = [helper childThreadContext];
         
         [moc performBlockAndWait:^{
             
             NSDate *date1 = [NSDate date];
             for(int i =0;i<500;i++)
             {
                 Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"               inManagedObjectContext:moc];
                 
                 person.name = @"core data";
                 person.age  = [NSNumber numberWithInt:i];
                 [self.localData addObject:person];
             }
             [moc save:nil];

             NSDate *date2 = [NSDate date];
             
             NSLog(@"%f",[date2 timeIntervalSinceDate:date1]);
     }];
    
         MAIN(^{
             [self.tableView reloadData];
             NSLog(@"main");
         });
         
 });
                                                             
                                                             
                                                             
}];
    [op start];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.localData = [NSMutableArray array];
    helper = [ZXCoreData sharedZXCoreData];
    
    
    

    NSManagedObjectContext *moc = [helper managedObjectContext];
    
    for(int i=0;i<25;i++)
    {
        Person *p = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                              inManagedObjectContext:moc];
        p.name = @"临时对象";
    }
    
    

    [self.tableView reloadData];
    
    
    
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    NSArray *array = [helper.managedObjectContext executeFetchRequest:request
                                                                error:&error];
    NSLog(@"count:%d",array.count);
    
    
    [self AFLoad];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.localData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    Person *p = (Person *)self.localData[indexPath.row];
    NSLog(@"%@",p.name);
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",p.name,p.age];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
