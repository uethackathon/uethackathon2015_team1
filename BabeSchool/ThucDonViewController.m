//
//  ThucDonViewController.m
//  BabeSchool
//
//  Created by thjnh195 on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "ThucDonViewController.h"
#import "foodmenu.h"
#import <MBProgressHUD.h>
@interface ThucDonViewController (){
    NSMutableArray *arrayFoods;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ThucDonViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self bindData];
    arrayFoods = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
    NSLog(@"%d",indexPath.row);
    cell.textLabel.text=[food.arrayFoods objectAtIndex:indexPath.row];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void) bindData {
    PFQuery *query = [PFQuery queryWithClassName:@"Menu"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
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
