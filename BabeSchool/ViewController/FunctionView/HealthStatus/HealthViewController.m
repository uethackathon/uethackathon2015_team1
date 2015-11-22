//
//  SucKhoeViewController.m
//  BabeSchool
//
//  Created by thjnh195 on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "HealthViewController.h"
#import "HealthCell.h"
#import "Health.h"
#import "KLCPopup.h"
#import "AddHealth.h"
#import <Parse/Parse.h>
#import <MBProgressHUD.h>
#import "MyLib.h"

@interface HealthViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableHealth;

@end

@implementation HealthViewController {
    NSMutableArray *arrayHealths;
    KLCPopup *popup;
    AddHealth *addHealth;
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
    [self doLoadHealth];
}

- (void) doLoadHealth {
    [arrayHealths removeAllObjects];
    PFQuery *query = [PFQuery queryWithClassName:@"Health"];
    [query orderByDescending:@"healthId"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        for (int index = 0; index < objects.count; index++) {
            Health *health = [Health getObjectFromParse:[objects objectAtIndex:index]];
            if (health) {
                [arrayHealths addObject:health];
            }
        }
        [_tableHealth reloadData];
    }];
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
        [popup showAtCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3.5) inView:self.view];
    }
}

- (void) btnDoneClick: (UIButton*) button {
    if (addHealth.txtHeight.text.length > 0 && addHealth.txtWeight.text.length > 0 && [MyLib isNumber:addHealth.txtHeight.text] && [MyLib isNumber:addHealth.txtWeight.text]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MM/yyyy";
    
        Health *health = [arrayHealths objectAtIndex:0];
    
        PFObject *newHealth = [PFObject objectWithClassName:@"Health"];
        newHealth[@"healthId"] = [NSNumber numberWithInteger:(health.healthId + 1)];
        newHealth[@"height"] =  [NSNumber numberWithFloat:[addHealth.txtHeight.text floatValue]];
        newHealth[@"weight"] = [NSNumber numberWithFloat:[addHealth.txtWeight.text floatValue]];
        newHealth[@"date"] =  [dateFormatter stringFromDate:[NSDate date]];
    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [newHealth saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self doLoadHealth];
        }];
    
        [popup dismiss:YES];
        addHealth.txtHeight.text = @"";
        addHealth.txtWeight.text = @"";
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Bạn nhập không đúng định dạng" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
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
