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
#import "SchoolDetailViewController.h"
#import "School.h"

@interface ListSchoolViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableSchools;

@end

@implementation ListSchoolViewController {
    NSMutableArray *arraySchools;
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
    _tableSchools.separatorColor = [UIColor clearColor];
    arraySchools = [[NSMutableArray alloc] init];
}

- (void) setupNavigationBar {
    self.navigationItem.title = @"Danh sách trường";
    UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [btnLogin setTitle:@"Đăng nhập" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnLogin.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnLogin addTarget:self action:@selector(btnLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnLogin];
}

- (void) bindData {
    NSURL *jsonFilePath = [[NSBundle mainBundle] URLForResource:@"schools" withExtension:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfURL:jsonFilePath];
    NSDictionary *dictSchools = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = [dictSchools objectForKey:@"data"];

    for (int index = 0; index < array.count; index++) {
        School *school = [School getObjectFromJSON:[array objectAtIndex:index]];
        if (school) {
            [arraySchools addObject:school];
        }
    }
    [_tableSchools reloadData];
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
    return arraySchools.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SchoolCell *cell = (SchoolCell*) [tableView dequeueReusableCellWithIdentifier:@"SchoolCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SchoolCell" owner:self options:nil] objectAtIndex:0];
        
        School *school = [arraySchools objectAtIndex:indexPath.row];
        [cell bindData:school];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    School *school = [arraySchools objectAtIndex:indexPath.row];
    SchoolDetailViewController *schoolDetailVC = [[SchoolDetailViewController alloc] initWithNibName:@"SchoolDetailViewController" bundle:nil];
    schoolDetailVC.modal = school;
    [self.navigationController pushViewController:schoolDetailVC animated:YES];
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
