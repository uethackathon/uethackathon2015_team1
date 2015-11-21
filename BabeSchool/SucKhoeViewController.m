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
#import "KLCPopup.h"
#import "AddHealth.h"

@interface SucKhoeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableHealth;

@end

@implementation SucKhoeViewController {
    NSMutableArray *arrayHealths;
    KLCPopup *popup;
    AddHealth *addHealth;
    NSMutableArray *arrayDict;
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
    addHealth = [[[NSBundle mainBundle] loadNibNamed:@"AddHealth" owner:self options:nil] objectAtIndex:0];
    [addHealth.btnDone addTarget:self action:@selector(btnDoneClick:) forControlEvents:UIControlEventTouchUpInside];
    [addHealth.btnCancel addTarget:self action:@selector(btnCancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [addHealth.layer setCornerRadius:5.0f];
    addHealth.txtHeight.delegate = self;
    popup = [KLCPopup popupWithContentView:addHealth];
}

- (void) setupNavigationBar {
    self.navigationItem.title = @"Theo dõi sức khoẻ";
    UIButton *btnAdd = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [btnAdd setTitle:@"Add" forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(btnAddClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnAdd];
}

- (void) bindData {
    arrayHealths = [[NSMutableArray alloc] init];
    arrayDict = [[NSMutableArray alloc] init];
    
    NSURL *jsonFilePath = [[NSBundle mainBundle] URLForResource:@"health" withExtension:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonFilePath];
    NSDictionary *dictHealth = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    arrayDict = [dictHealth objectForKey:@"data"];
    
    for (int index = 0; index < arrayDict.count; index++) {
        Health *health = [Health getObjectFromDict:[arrayDict objectAtIndex:index]];
        if (health) {
            [arrayHealths addObject:health];
        }
    }
    [_tableHealth reloadData];
}

#pragma mark - Setup Button Action
- (void) btnAddClick: (UIButton*) button {
    Health *health = [arrayHealths objectAtIndex:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    NSString *today = [dateFormatter stringFromDate:[NSDate date]];
    if ([today isEqualToString:health.date]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Hôm nay bạn đã nhập rồi" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        view.backgroundColor = [UIColor blackColor];
        [popup show];
    }
}

- (void) btnDoneClick: (UIButton*) button {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    
    Health *health = [arrayHealths objectAtIndex:0];
    Health *newHealth = [[Health alloc] init];
    newHealth.healthId = health.healthId++;
    newHealth.height = [addHealth.txtHeight.text floatValue];
    newHealth.weight = [addHealth.txtWeight.text floatValue];
    newHealth.date = [dateFormatter stringFromDate:[NSDate date]];
    
    
    [popup dismiss:YES];
    addHealth.txtHeight.text = @"";
    addHealth.txtWeight.text = @"";
}

- (void) btnCancelClick: (UIButton*) button {
    [popup dismiss:YES];
    addHealth.txtHeight.text = @"";
    addHealth.txtWeight.text = @"";
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
