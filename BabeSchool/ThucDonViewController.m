//
//  ThucDonViewController.m
//  BabeSchool
//
//  Created by thjnh195 on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "ThucDonViewController.h"
#import "foodmenu.h"
@interface ThucDonViewController (){
    NSMutableArray *arrayFoods;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ThucDonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayFoods = [[NSMutableArray alloc]init];
    [self bindData];
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
    return 2;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"Bữa sáng";
    }
    else{
        return @"Bữa Trưa";
    }
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
    NSURL *jsonFilePath = [[NSBundle mainBundle] URLForResource:@"menu" withExtension:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonFilePath];
    NSDictionary *dictSchools = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = [dictSchools objectForKey:@"data"];
    
    for (int index = 0; index < array.count; index++) {
        foodmenu *food = [foodmenu getObjectFromJSON:[array objectAtIndex:index]];
        if (food) {
            [arrayFoods addObject:food];
            
        }
    }
    [self.tableView reloadData];
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
