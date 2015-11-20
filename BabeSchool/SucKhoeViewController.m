//
//  SucKhoeViewController.m
//  BabeSchool
//
//  Created by thjnh195 on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "SucKhoeViewController.h"
#import "HealthCell.h"
#import "Health.h"

@interface SucKhoeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableHealth;

@end

@implementation SucKhoeViewController {
    NSMutableArray *arrayHealths;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
    [self setupNavigationBar];
    [self bindData];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup View Controller 
- (void) setupViewController {
    _tableHealth.separatorColor = [UIColor clearColor];
}

- (void) setupNavigationBar {
    self.navigationItem.title = @"Theo dõi sức khoẻ";
    UIButton *btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [btnAdd setTitle:@"Add" forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
}

- (void) bindData {
    arrayHealths = [[NSMutableArray alloc] init];
    
    NSURL *jsonFilePath = [[NSBundle mainBundle] URLForResource:@"health" withExtension:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonFilePath];
    NSDictionary *dictHealth = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = [dictHealth objectForKey:@"data"];
    
    for (int index = 0; index < array.count; index++) {
        Health *health = [Health getObjectFromDict:[array objectAtIndex:index]];
        if (health) {
            [arrayHealths addObject:health];
        }
    }
    [_tableHealth reloadData];
}

#pragma mark - Setup Table Health Status
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayHealths.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HealthCell *cell = (HealthCell*) [tableView dequeueReusableCellWithIdentifier:@"HealthCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HealthCell" owner:self options:nil] objectAtIndex:0];
        Health *health = [arrayHealths objectAtIndex:indexPath.row];
        [cell bindData:health];
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
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
