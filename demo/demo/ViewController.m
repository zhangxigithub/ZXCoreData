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
#import "Detail.h"

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
         
         [NSThread sleepForTimeInterval:2];
         NSManagedObjectContext *moc = [helper childThreadContext];
         
         [moc performBlockAndWait:^{
             
             NSDate *date1 = [NSDate date];
             for(NSDictionary *onePerson in JSON)
             {
                 Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"               inManagedObjectContext:moc];
                 
                 person.name = onePerson[@"name"];
                 person.age  = onePerson[@"age"];
                 
                 
                 for(NSDictionary *f in onePerson[@"friends"])
                 {
                     Person *p = [NSEntityDescription insertNewObjectForEntityForName:@"Person"               inManagedObjectContext:moc];
                     
                     p.name = f[@"name"];
                     p.age  = f[@"age"];
                    
                     p.myfriends = person;

                 }
                 
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
    


    

    [self.tableView reloadData];
    
    
    
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    NSArray *array = [helper.managedObjectContext executeFetchRequest:request
                                                                error:&error];
    NSLog(@"count:%d",array.count);
    self.navigationItem.title = [NSString stringWithFormat:@"%d",array.count];
    
    [self AFLoad];
    
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"load"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self
                                                            action:@selector(load)];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)load
{
    ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@",p.name];
    
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
    
    Person *p = self.localData[indexPath.row];
    
    
    Detail *detail = [[Detail alloc] initWithNibName:@"Detail" bundle:nil];
    detail.navigationItem.title = p.name;
    detail.localData = [p.friends allObjects];
    
    [self.navigationController pushViewController:detail animated:YES];
}

@end
