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
#import "MyLib.h"
#import "FunctionViewController.h"
#import <Parse/Parse.h>
#import <MBProgressHUD.h>

@interface ListSchoolViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableSchools;

@end

@implementation ListSchoolViewController {
    NSMutableArray *arraySchools;
    UITextField *txtSearch;
    NSMutableArray *arraySchoolsSearched;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
    [self bindData];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated {
    [self setupNavigationBar];
    arraySchoolsSearched = [NSMutableArray arrayWithArray:arraySchools];
    [_tableSchools reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup View Controller
- (void) setupViewController {
    _tableSchools.separatorColor = [UIColor clearColor];
    arraySchools = [[NSMutableArray alloc] init];
    arraySchoolsSearched = [[NSMutableArray alloc] init];
}

- (void) setupNavigationBar {
    txtSearch = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 170, 30)];
    txtSearch.backgroundColor = [UIColor whiteColor];
    txtSearch.font = [UIFont systemFontOfSize:15];
    txtSearch.tintColor = [UIColor blackColor];
    txtSearch.delegate = self;
    UIButton *btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btnSearch setImage:[UIImage imageNamed:@"btn_search.png"] forState:UIControlStateNormal];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    txtSearch.rightView = rightView;
    txtSearch.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    txtSearch.leftView = leftView;
    txtSearch.leftViewMode = UITextFieldViewModeAlways;
    
    [rightView addSubview:btnSearch];
    
    [txtSearch addTarget:self action:@selector(searchFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
    self.navigationItem.titleView = txtSearch;
    if (![MyLib logined]) {
        UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
        [btnLogin setImage:[UIImage imageNamed:@"btn_login.png"] forState:UIControlStateNormal];
        btnLogin.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btnLogin addTarget:self action:@selector(btnLoginClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnLogin];
    }
    else {
        UIButton *btnFunction = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
        [btnFunction setImage:[UIImage imageNamed:@"btn_function.png"] forState:UIControlStateNormal];
        btnFunction.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btnFunction addTarget:self action:@selector(btnFunctionClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnFunction];
    }
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [txtSearch resignFirstResponder];
    return YES;
}

- (void) bindData {
    PFQuery *query = [PFQuery queryWithClassName:@"Schools"];
    [query orderByAscending:@"schoolId"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        for (int index = 0; index < objects.count; index++) {
            School *school = [School getObjectFromParse:[objects objectAtIndex:index]];
            if (school) {
                [arraySchools addObject:school];
            }
        }
        arraySchoolsSearched = [NSMutableArray arrayWithArray:arraySchools];
        [_tableSchools reloadData];
    }];
}

- (BOOL) isRootView {
    UIViewController *vc = [[self.navigationController viewControllers] objectAtIndex:0];
    
    if([vc isEqual: self ])
    {
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark - Setup Button Action
- (void) btnLoginClick: (UIButton*)button {
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void) btnFunctionClick: (UIButton*)button {
    if ([self isRootView]) {
        FunctionViewController *function = [[FunctionViewController alloc] initWithNibName:@"FunctionViewController" bundle:nil];
        [self.navigationController pushViewController:function animated:YES];
    }
    else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void) searchFieldTextChanged: (id) sender {
    NSString *keySearch = [MyLib normalizeVietnameseString:[txtSearch.text lowercaseString]];
    if (keySearch.length > 0) {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for (int index = 0; index < arraySchools.count; index++) {
            School *school = [arraySchools objectAtIndex:index];
            if ([school.unsignedName rangeOfString:keySearch].location != NSNotFound) {
                [result addObject:school];
                NSLog(@"%@", result);
            }
        }
        arraySchoolsSearched = [NSMutableArray arrayWithArray:result];
    }else{
        arraySchoolsSearched = [NSMutableArray arrayWithArray:arraySchools];
    }
    [_tableSchools reloadData];
}
#pragma mark - Setup Table School
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arraySchoolsSearched.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SchoolCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SchoolCell" owner:self options:nil] objectAtIndex:0];
        
    School *school = [arraySchoolsSearched objectAtIndex:indexPath.row];
    [cell bindData:school];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [txtSearch resignFirstResponder];
    School *school = [arraySchoolsSearched objectAtIndex:indexPath.row];
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
