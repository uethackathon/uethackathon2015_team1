//
//  ListSchoolViewController.m
//  BabeSchool
//
//  Created by Truong Huu Thao on 11/20/15.
//  Copyright © 2015 Nguyễn Chí Hoàng. All rights reserved.
//

#import "ListSchoolViewController.h"
#import "SchoolCell.h"
#import "LoginViewController.h"

@interface ListSchoolViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableSchools;

@end

@implementation ListSchoolViewController {
    NSArray *arraySchools;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Setup View Controller
- (void) setupNavigationBar {
    UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [btnLogin setTitle:@"Đăng nhập" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnLogin.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnLogin addTarget:self action:@selector(btnLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnLogin];
}

#pragma mark - Setup Button Action
- (void) btnLoginClick: (UIButton*)button {
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginVC animated:YES];
}
#pragma mark - Setup Table School 
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SchoolCell *cell = (SchoolCell*) [tableView dequeueReusableCellWithIdentifier:@"SchoolCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SchoolCell" owner:self options:nil] objectAtIndex:0];
        cell.lbName.text = @"Trường mầm non Hoa Hướng Dương";
        cell.lbAddress.text = @"Số 10, Hoàng Quốc Việt, Hà Nội";
        cell.lbDescription.text = @"Đây là một ngôi trường có truyền thống lâu năm, nằm trên đường Hoàng Quốc Việt, bla bla bla ...";
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
