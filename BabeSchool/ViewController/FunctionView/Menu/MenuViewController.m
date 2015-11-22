//
//  ThucDonViewController.m
//  BabeSchool
//
//  Created by thjnh195 on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "MenuViewController.h"
#import "foodmenu.h"
#import <MBProgressHUD.h>
@interface MenuViewController (){
    NSMutableArray *arrayFoods;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"Thực đơn";
    [self bindData];
    arrayFoods = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    foodmenu *food =[arrayFoods objectAtIndex:section];
    return  [food.arrayFoods count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [arrayFoods count];
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return ((foodmenu*)[arrayFoods objectAtIndex:section]).name;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"Cell"];
    
    foodmenu *food =[arrayFoods objectAtIndex:indexPath.section];
    NSLog(@"%ld",(long)indexPath.row);
    cell.textLabel.text=[food.arrayFoods objectAtIndex:indexPath.row];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

-(void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//    view.tintColor = [UIColor colorWithRed:179.0f green:164.0f blue:164.0f alpha:255.0];
}

- (void) bindData {
    PFQuery *query = [PFQuery queryWithClassName:@"Menu"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                foodmenu *food = [foodmenu getObjectFromParse:object];
                [arrayFoods addObject:food];
            }
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
